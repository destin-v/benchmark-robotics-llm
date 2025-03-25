######################################################
# ChatGPT
######################################################

# Single Agent (Centralized Full Obs)
python -m habitat_llm.examples.planner_demo --config-name experiments/single_agent_zero_shot_full_obs_react_summary.yaml \
    habitat.dataset.data_path="data/datasets/partnr_episodes/v0_0/val_mini.json.gz" \
    llm@evaluation.agents.agent_0.planner.plan_config.llm=openai_chat


# Single Agent (Centralized Partial Obs)
python -m habitat_llm.examples.planner_demo --config-name experiments/single_agent_zero_shot_partial_obs_react_summary.yaml \
    habitat.dataset.data_path="data/datasets/partnr_episodes/v0_0/val_mini.json.gz" \
    llm@evaluation.agents.agent_0.planner.plan_config.llm=openai_chat


# ChatGPT (Centralized Full Obs)
python -m habitat_llm.examples.planner_demo --config-name experiments/centralized_few_shot_full_obs_react_summary.yaml \
    habitat.dataset.data_path="data/datasets/partnr_episodes/v0_0/val_mini.json.gz" \
    llm@evaluation.agents.agent_0.planner.plan_config.llm=openai_chat


# ChatGPT (Centralized Partial Obs)
python -m habitat_llm.examples.planner_demo --config-name experiments/centralized_few_shot_partial_obs_react_summary.yaml \
    habitat.dataset.data_path="data/datasets/partnr_episodes/v0_0/val_mini.json.gz" \
    llm@evaluation.agents.agent_0.planner.plan_config.llm=openai_chat


# ChatGPT (Decentralized Full Obs)
python -m habitat_llm.examples.planner_demo --config-name experiments/decentralized_few_shot_full_obs_react_baseline.yaml \
    habitat.dataset.data_path="data/datasets/partnr_episodes/v0_0/val_mini.json.gz" \
    llm@evaluation.agents.agent_0.planner.plan_config.llm=openai_chat


# ChatGPT (Decentralized Partial Obs)
python -m habitat_llm.examples.planner_demo --config-name experiments/decentralized_few_shot_partial_obs_react_baseline.yaml \
    habitat.dataset.data_path="data/datasets/partnr_episodes/v0_0/val_mini.json.gz" \
    llm@evaluation.agents.agent_0.planner.plan_config.llm=openai_chat

######################################################
# DeepSeek
######################################################

# Single Agent (Centralized Full Obs)
python -m habitat_llm.examples.planner_demo --config-name experiments/single_agent_zero_shot_full_obs_react_summary.yaml \
    habitat.dataset.data_path="data/datasets/partnr_episodes/v0_0/val_mini.json.gz" \
    evaluation.planner.plan_config.llm.inference_mode=hf \
    evaluation.planner.plan_config.llm.generation_params.engine=deepseek-ai/DeepSeek-R1-Distill-Llama-8B


# Single Agent (Centralized Partial Obs)
python -m habitat_llm.examples.planner_demo --config-name experiments/single_agent_zero_shot_partial_obs_react_summary.yaml \
    habitat.dataset.data_path="data/datasets/partnr_episodes/v0_0/val_mini.json.gz" \
    evaluation.planner.plan_config.llm.inference_mode=hf \
    evaluation.planner.plan_config.llm.generation_params.engine=deepseek-ai/DeepSeek-R1-Distill-Llama-8B


# DeepSeek-R1-Distilled-Llama-8B (Centralized Full Obs)
python -m habitat_llm.examples.planner_demo --config-name experiments/centralized_few_shot_full_obs_react_summary.yaml \
    habitat.dataset.data_path="data/datasets/partnr_episodes/v0_0/val_mini.json.gz" \
    evaluation.planner.plan_config.llm.inference_mode=hf \
    evaluation.planner.plan_config.llm.generation_params.engine=deepseek-ai/DeepSeek-R1-Distill-Llama-8B


# DeepSeek-R1-Distilled-Llama-8B (Centralized Partial Obs)
python -m habitat_llm.examples.planner_demo --config-name experiments/centralized_few_shot_partial_obs_react_summary.yaml \
    habitat.dataset.data_path="data/datasets/partnr_episodes/v0_0/val_mini.json.gz" \
    evaluation.planner.plan_config.llm.inference_mode=hf \
    evaluation.planner.plan_config.llm.generation_params.engine=deepseek-ai/DeepSeek-R1-Distill-Llama-8B


# DeepSeek-R1-Distilled-Llama-8B  (Decentralized Full Obs)
python -m habitat_llm.examples.planner_demo --config-name experiments/decentralized_few_shot_full_obs_react_baseline.yaml \
    habitat.dataset.data_path="data/datasets/partnr_episodes/v0_0/val_mini.json.gz" \
    evaluation.planner.plan_config.llm.inference_mode=hf \
    evaluation.planner.plan_config.llm.generation_params.engine=deepseek-ai/DeepSeek-R1-Distill-Llama-8B


# DeepSeek-R1-Distilled-Llama-8B  (Decentralized Partial Obs)
python -m habitat_llm.examples.planner_demo --config-name experiments/decentralized_few_shot_partial_obs_react_baseline.yaml \
    habitat.dataset.data_path="data/datasets/partnr_episodes/v0_0/val_mini.json.gz" \
    evaluation.planner.plan_config.llm.inference_mode=hf \
    evaluation.planner.plan_config.llm.generation_params.engine=deepseek-ai/DeepSeek-R1-Distill-Llama-8B


######################################################
# Mistral
######################################################

# Single Agent (Centralized Full Obs)
python -m habitat_llm.examples.planner_demo --config-name experiments/single_agent_zero_shot_full_obs_react_summary.yaml \
    habitat.dataset.data_path="data/datasets/partnr_episodes/v0_0/val_mini.json.gz" \
    evaluation.planner.plan_config.llm.inference_mode=hf \
    evaluation.planner.plan_config.llm.generation_params.engine=mistralai/Mistral-7B-Instruct-v0.3


# Single Agent (Centralized Partial Obs)
python -m habitat_llm.examples.planner_demo --config-name experiments/single_agent_zero_shot_partial_obs_react_summary.yaml \
    habitat.dataset.data_path="data/datasets/partnr_episodes/v0_0/val_mini.json.gz" \
    evaluation.planner.plan_config.llm.inference_mode=hf \
    evaluation.planner.plan_config.llm.generation_params.engine=mistralai/Mistral-7B-Instruct-v0.3


# Mistral-7B-Instruct-v0.3 (Centralized Full Obs)
python -m habitat_llm.examples.planner_demo --config-name experiments/centralized_few_shot_full_obs_react_summary.yaml \
    habitat.dataset.data_path="data/datasets/partnr_episodes/v0_0/val_mini.json.gz" \
    evaluation.planner.plan_config.llm.inference_mode=hf \
    evaluation.planner.plan_config.llm.generation_params.engine=mistralai/Mistral-7B-Instruct-v0.3


# Mistral-7B-Instruct-v0.3 (Centralized Partial Obs)
python -m habitat_llm.examples.planner_demo --config-name experiments/centralized_few_shot_partial_obs_react_summary.yaml  \
    habitat.dataset.data_path="data/datasets/partnr_episodes/v0_0/val_mini.json.gz" \
    evaluation.planner.plan_config.llm.inference_mode=hf \
    evaluation.planner.plan_config.llm.generation_params.engine=mistralai/Mistral-7B-Instruct-v0.3


# Mistral-7B-Instruct-v0.3  (Decentralized Full Obs)
python -m habitat_llm.examples.planner_demo --config-name experiments/decentralized_few_shot_full_obs_react_baseline.yaml \
    habitat.dataset.data_path="data/datasets/partnr_episodes/v0_0/val_mini.json.gz" \
    evaluation.planner.plan_config.llm.inference_mode=hf \
    evaluation.planner.plan_config.llm.generation_params.engine=mistralai/Mistral-7B-Instruct-v0.3


# Mistral-7B-Instruct-v0.3  (Decentralized Partial Obs)
python -m habitat_llm.examples.planner_demo --config-name experiments/decentralized_few_shot_partial_obs_react_baseline.yaml \
    habitat.dataset.data_path="data/datasets/partnr_episodes/v0_0/val_mini.json.gz" \
    evaluation.planner.plan_config.llm.inference_mode=hf \
    evaluation.planner.plan_config.llm.generation_params.engine=mistralai/Mistral-7B-Instruct-v0.3


# Evaluation
# python scripts/read_results.py


# # Optional
# # DeepSeek-R1-Distilled-Qwen-7B (Centralized Full Obs)
# python -m habitat_llm.examples.planner_demo --config-name experiments/deepseek_centralized_few_shot_full_obs_react_summary.yaml \
#     habitat.dataset.data_path="data/datasets/partnr_episodes/v0_0/val_mini.json.gz" \
#     evaluation.planner.plan_config.llm.inference_mode=hf \
#     evaluation.planner.plan_config.llm.generation_params.engine=deepseek-ai/DeepSeek-R1-Distill-Qwen-7B


# # DeepSeek-R1-Distilled-Qwen-7B (Centralized Partial Obs)
# python -m habitat_llm.examples.planner_demo --config-name experiments/deepseek_centralized_few_shot_partial_obs_react_summary.yaml \
#     habitat.dataset.data_path="data/datasets/partnr_episodes/v0_0/val_mini.json.gz" \
#     evaluation.planner.plan_config.llm.inference_mode=hf \
#     evaluation.planner.plan_config.llm.generation_params.engine=deepseek-ai/DeepSeek-R1-Distill-Qwen-7B

