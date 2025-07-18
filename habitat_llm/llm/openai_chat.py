#!/usr/bin/env python3

# Copyright (c) Meta Platforms, Inc. and affiliates.
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree

import os
from typing import Dict, List, Optional

from omegaconf import DictConfig, OmegaConf
from openai import OpenAI
from rich.pretty import pprint

from habitat_llm.llm.base_llm import BaseLLM, Prompt


def generate_message(multimodal_prompt, image_detail="auto"):
    # Converts the multimodal prompt to the OpenAI format.
    content = []
    for prompt_type, prompt_value in multimodal_prompt:
        if prompt_type == "text":
            message_item = {"type": "text", "text": prompt_value}
        else:
            message_item = {
                "type": "image_url",
                "image_url": {
                    "url": prompt_value,
                    "detail": image_detail,
                },
            }
        content.append(message_item)
    return {"role": "user", "content": content}


class OpenAIChat(BaseLLM):
    def __init__(self, conf: DictConfig):
        """
        Initialize the chat model.
        :param conf: the configuration of the language model
        """
        self.llm_conf = conf
        pprint("User configuration:")
        pprint(dict(self.llm_conf), expand_all=True)
        pprint(f"Model Selected: {self.llm_conf.model_selected}")

        self.generation_params = self.llm_conf.generation_params
        try:
            api_key = os.getenv("OPENAI_API_KEY")
            assert len(api_key) > 0, ValueError("No OPENAI_API_KEY keys provided")
        except Exception:
            raise ValueError("No OPENAI API keys provided")
        try:
            endpoint = os.getenv("OPENAI_ENDPOINT")
            assert len(endpoint) > 0, ValueError("No OPENAI_ENDPOINT keys provided")
        except Exception:
            raise ValueError("No OPENAI endpoint keys provided")

        # WARNING: AzureOpenAI is deprecated!  DO NOT USE!
        # self.client = AzureOpenAI(
        #     api_version="2024-06-01",
        #     api_key=api_key,
        #     azure_endpoint=f"https://{endpoint}",
        # )

        self.client = OpenAI()
        self._validate_conf()
        self.verbose = self.llm_conf.verbose
        self.verbose = True
        self.message_history: List[Dict] = []
        self.keep_message_history = self.llm_conf.keep_message_history

    def _validate_conf(self):
        if self.generation_params.stream:
            raise ValueError("Streaming not supported")

    # @retry(Timeout, tries=3)
    def generate(
        self,
        prompt: Prompt,
        stop: Optional[str] = None,
        max_length: Optional[int] = None,
        generation_args=None,
        request_timeout: int = 40,
    ):
        """
        Generate a response autoregressively.
        :param prompt: A string with the input to the language model.
        :param image: Image input
        :param stop: A string that determines when to stop generation
        :param max_length: The max number of tokens to generate.
        :param request_timeout: maximum time before timeout.
        :param generation_args: contains arguments like the grammar definition. We don't use this here
        """

        params = OmegaConf.to_object(self.generation_params)

        # Override stop if provided
        if stop is None and len(self.generation_params.stop) > 0:
            stop = self.generation_params.stop
        params["stop"] = stop

        # Override max_length if provided
        if max_length is not None:
            params["max_tokens"] = max_length

        messages = self.message_history.copy()
        # Add system message if no messages
        if len(messages) == 0:
            messages.append({"role": "system", "content": self.llm_conf.system_message})

        params["request_timeout"] = request_timeout
        if type(prompt) is str:
            # Add current message
            messages.append({"role": "user", "content": prompt})

        else:
            # Multimodal prompt
            image_detail = "low"  # high/low/auto
            messages.append(generate_message(prompt, image_detail=image_detail))

        text_response = self.client.chat.completions.create(
            model=self.llm_conf.model_selected, messages=messages
        )

        text_response = text_response.choices[0].message.content
        self.response = text_response

        # Update message history
        if self.keep_message_history:
            self.message_history = messages.copy()
            self.message_history.append({"role": "assistant", "content": text_response})

        if stop is not None:
            text_response = text_response.split(stop)[0]
        return text_response
