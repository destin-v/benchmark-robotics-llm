######################################################
# ChatGPT
######################################################

#-----------------------------------------------------
# Centralized
#-----------------------------------------------------
# Full Obs
python -m habitat_llm.examples.planner_demo --config-name experiments/centralized_zero_shot_react_full_obs_summary.yaml \
    habitat.dataset.data_path="data/datasets/partnr_episodes/v0_0/val_mini.json.gz" \
    llm@evaluation.agents.agent_0.planner.plan_config.llm=openai_chat

# Partial Obs
python -m habitat_llm.examples.planner_demo --config-name experiments/centralized_zero_shot_react_partial_obs_summary.yaml \
    habitat.dataset.data_path="data/datasets/partnr_episodes/v0_0/val_mini.json.gz" \
    llm@evaluation.agents.agent_0.planner.plan_config.llm=openai_chat

#-----------------------------------------------------
# Decentralized
#-----------------------------------------------------
# Full Obs
python -m habitat_llm.examples.planner_demo --config-name experiments/decentralized_zero_shot_react_full_obs_summary.yaml \
    habitat.dataset.data_path="data/datasets/partnr_episodes/v0_0/val_mini.json.gz" \
    llm@evaluation.agents.agent_0.planner.plan_config.llm=openai_chat \
    llm@evaluation.agents.agent_1.planner.plan_config.llm=openai_chat

# Partial Obs
python -m habitat_llm.examples.planner_demo --config-name experiments/decentralized_zero_shot_react_partial_obs_summary.yaml \
    habitat.dataset.data_path="data/datasets/partnr_episodes/v0_0/val_mini.json.gz" \
    llm@evaluation.agents.agent_0.planner.plan_config.llm=openai_chat \
    llm@evaluation.agents.agent_1.planner.plan_config.llm=openai_chat

######################################################
# DeepSeek-R1-Distilled-Llama-8B
######################################################

#-----------------------------------------------------
# Centralized
#-----------------------------------------------------
# Full Obs
python -m habitat_llm.examples.planner_demo --config-name baselines/centralized_zero_shot_react_full_obs_summary.yaml \
    habitat.dataset.data_path="data/datasets/partnr_episodes/v0_0/val_mini.json.gz" \
    evaluation.planner.plan_config.llm.inference_mode=hf \
    evaluation.planner.plan_config.llm.generation_params.engine=deepseek-ai/DeepSeek-R1-Distill-Llama-8B

# Partial Obs
python -m habitat_llm.examples.planner_demo --config-name experiments/centralized_zero_shot_react_partial_obs_summary.yaml \
    habitat.dataset.data_path="data/datasets/partnr_episodes/v0_0/val_mini.json.gz" \
    evaluation.planner.plan_config.llm.inference_mode=hf \
    evaluation.planner.plan_config.llm.generation_params.engine=deepseek-ai/DeepSeek-R1-Distill-Llama-8B

#-----------------------------------------------------
# Decentralized
#-----------------------------------------------------
# Full Obs
python -m habitat_llm.examples.planner_demo --config-name experiments/decentralized_zero_shot_react_full_obs_summary.yaml \
    habitat.dataset.data_path="data/datasets/partnr_episodes/v0_0/val_mini.json.gz" \
    evaluation.agents.agent_0.planner.plan_config.llm.inference_mode=hf \
    evaluation.agents.agent_1.planner.plan_config.llm.inference_mode=hf \
    evaluation.agents.agent_0.planner.plan_config.llm.generation_params.engine=deepseek-ai/DeepSeek-R1-Distill-Llama-8B \
    evaluation.agents.agent_1.planner.plan_config.llm.generation_params.engine=deepseek-ai/DeepSeek-R1-Distill-Llama-8B

# Partial Obs
python -m habitat_llm.examples.planner_demo --config-name experiments/decentralized_zero_shot_react_partial_obs_summary.yaml \
    habitat.dataset.data_path="data/datasets/partnr_episodes/v0_0/val_mini.json.gz" \
    evaluation.agents.agent_0.planner.plan_config.llm.inference_mode=hf \
    evaluation.agents.agent_1.planner.plan_config.llm.inference_mode=hf \
    evaluation.agents.agent_0.planner.plan_config.llm.generation_params.engine=deepseek-ai/DeepSeek-R1-Distill-Llama-8B \
    evaluation.agents.agent_1.planner.plan_config.llm.generation_params.engine=deepseek-ai/DeepSeek-R1-Distill-Llama-8B

######################################################
# Mistral-7B-Instruct-v0.3
######################################################

#-----------------------------------------------------
# Centralized
#-----------------------------------------------------
# Full Obs
python -m habitat_llm.examples.planner_demo --config-name experiments/centralized_zero_shot_react_full_obs_summary.yaml \
    habitat.dataset.data_path="data/datasets/partnr_episodes/v0_0/val_mini.json.gz" \
    evaluation.planner.plan_config.llm.inference_mode=hf \
    evaluation.planner.plan_config.llm.generation_params.engine=mistralai/Mistral-7B-Instruct-v0.3

# Partial Obs
python -m habitat_llm.examples.planner_demo --config-name experiments/centralized_zero_shot_react_partial_obs_summary.yaml  \
    habitat.dataset.data_path="data/datasets/partnr_episodes/v0_0/val_mini.json.gz" \
    evaluation.planner.plan_config.llm.inference_mode=hf \
    evaluation.planner.plan_config.llm.generation_params.engine=mistralai/Mistral-7B-Instruct-v0.3

#-----------------------------------------------------
# Decentralized
#-----------------------------------------------------
# Full Obs
python -m habitat_llm.examples.planner_demo --config-name experiments/decentralized_zero_shot_react_full_obs_summary.yaml \
    habitat.dataset.data_path="data/datasets/partnr_episodes/v0_0/val_mini.json.gz" \
    evaluation.agents.agent_0.planner.plan_config.llm.inference_mode=hf \
    evaluation.agents.agent_1.planner.plan_config.llm.inference_mode=hf \
    evaluation.agents.agent_0.planner.plan_config.llm.generation_params.engine=mistralai/Mistral-7B-Instruct-v0.3 \
    evaluation.agents.agent_1.planner.plan_config.llm.generation_params.engine=mistralai/Mistral-7B-Instruct-v0.3

# Partial Obs
python -m habitat_llm.examples.planner_demo --config-name experiments/decentralized_zero_shot_react_partial_obs_summary.yaml \
    habitat.dataset.data_path="data/datasets/partnr_episodes/v0_0/val_mini.json.gz" \
    evaluation.agents.agent_0.planner.plan_config.llm.inference_mode=hf \
    evaluation.agents.agent_1.planner.plan_config.llm.inference_mode=hf \
    evaluation.agents.agent_0.planner.plan_config.llm.generation_params.engine=mistralai/Mistral-7B-Instruct-v0.3 \
    evaluation.agents.agent_1.planner.plan_config.llm.generation_params.engine=mistralai/Mistral-7B-Instruct-v0.3

######################################################
# Evaluation
######################################################
python scripts/read_results.py outputs/
