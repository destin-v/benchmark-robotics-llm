# # Meta-Llama-3-8B
# python -m habitat_llm.examples.planner_demo --config-name baselines/centralized_zero_shot_react_summary.yaml \
#     habitat.dataset.data_path="data/datasets/partnr_episodes/v0_0/val_mini.json.gz" \
#     evaluation.planner.plan_config.llm.inference_mode=hf \
#     evaluation.planner.plan_config.llm.generation_params.engine=meta-llama/Meta-Llama-3-8B-Instruct


DeepSeek-R1-Distilled-Llama-8B
python -m habitat_llm.examples.planner_demo --config-name baselines/deepseek_centralized_zero_shot_react_summary.yaml \
    habitat.dataset.data_path="data/datasets/partnr_episodes/v0_0/val_mini.json.gz" \
    evaluation.planner.plan_config.llm.inference_mode=hf \
    evaluation.planner.plan_config.llm.generation_params.engine=deepseek-ai/DeepSeek-R1-Distill-Llama-8B


# # DeepSeek-R1-Distilled-Qwen-7B
# python -m habitat_llm.examples.planner_demo --config-name baselines/deepseek_centralized_zero_shot_react_summary.yaml \
#     habitat.dataset.data_path="data/datasets/partnr_episodes/v0_0/val_mini.json.gz" \
#     evaluation.planner.plan_config.llm.inference_mode=hf \
#     evaluation.planner.plan_config.llm.generation_params.engine=deepseek-ai/DeepSeek-R1-Distill-Qwen-7B


# # Gemma2
# python -m habitat_llm.examples.planner_demo --config-name baselines/deepseek_centralized_zero_shot_react_summary.yaml \
#     habitat.dataset.data_path="data/datasets/partnr_episodes/v0_0/val_mini.json.gz" \
#     evaluation.planner.plan_config.llm.inference_mode=hf \
#     evaluation.planner.plan_config.llm.generation_params.engine=google/gemma-2-2b-it


# # Phi
# python -m habitat_llm.examples.planner_demo --config-name baselines/deepseek_centralized_zero_shot_react_summary.yaml \
#     habitat.dataset.data_path="data/datasets/partnr_episodes/v0_0/val_mini.json.gz" \
#     evaluation.planner.plan_config.llm.inference_mode=hf \
#     evaluation.planner.plan_config.llm.generation_params.engine=microsoft/Phi-4-mini-instruct


# Evaluation
# python scripts/read_results.py
