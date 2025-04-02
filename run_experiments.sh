######################################################
# OpenAI API
######################################################

#-----------------------------------------------------
# Centralized
#-----------------------------------------------------
# Full Obs
python -m habitat_llm.examples.planner_demo --config-name experiments/centralized_zero_shot_react_full_obs_summary.yaml \
    habitat.dataset.data_path="data/datasets/partnr_episodes/v0_0/val_mini.json.gz" \
    paths.results_dir="outputs/test/openai/central_react_openai_fullobs" \
    llm@evaluation.planner.plan_config.llm=openai_chat \
    evaluation.planner.plan_config.llm.model_selected="/home/gridsan/DA32121/llm_shared/models/hub/models--deepseek-ai--DeepSeek-R1/snapshots/5a56bdbde75a16bdfbf3a8e9c852be3dfcfb8eef"

# Partial Obs
python -m habitat_llm.examples.planner_demo --config-name experiments/centralized_zero_shot_react_partial_obs_summary.yaml \
    habitat.dataset.data_path="data/datasets/partnr_episodes/v0_0/val_mini.json.gz" \
    paths.results_dir="outputs/test/openai/central_react_openai_partobs" \
    llm@evaluation.planner.plan_config.llm=openai_chat \
    evaluation.planner.plan_config.llm.model_selected="/home/gridsan/DA32121/llm_shared/models/hub/models--deepseek-ai--DeepSeek-R1/snapshots/5a56bdbde75a16bdfbf3a8e9c852be3dfcfb8eef"

#-----------------------------------------------------
# Decentralized
#-----------------------------------------------------
# Full Obs
python -m habitat_llm.examples.planner_demo --config-name experiments/decentralized_zero_shot_react_full_obs_summary.yaml \
    habitat.dataset.data_path="data/datasets/partnr_episodes/v0_0/val_mini.json.gz" \
    paths.results_dir="outputs/test/openai/decentral_react_openai_fullobs" \
    llm@evaluation.agents.agent_0.planner.plan_config.llm=openai_chat \
    llm@evaluation.agents.agent_1.planner.plan_config.llm=openai_chat \
    evaluation.agents.agent_0.planner.plan_config.llm.model_selected="/home/gridsan/DA32121/llm_shared/models/hub/models--deepseek-ai--DeepSeek-R1/snapshots/5a56bdbde75a16bdfbf3a8e9c852be3dfcfb8eef" \
    evaluation.agents.agent_1.planner.plan_config.llm.model_selected="/home/gridsan/DA32121/llm_shared/models/hub/models--deepseek-ai--DeepSeek-R1/snapshots/5a56bdbde75a16bdfbf3a8e9c852be3dfcfb8eef"

# Partial Obs
python -m habitat_llm.examples.planner_demo --config-name experiments/decentralized_zero_shot_react_partial_obs_summary.yaml \
    habitat.dataset.data_path="data/datasets/partnr_episodes/v0_0/val_mini.json.gz" \
    paths.results_dir="outputs/test/openai/decentral_react_openai_partobs" \
    llm@evaluation.agents.agent_0.planner.plan_config.llm=openai_chat \
    llm@evaluation.agents.agent_1.planner.plan_config.llm=openai_chat \
    evaluation.agents.agent_0.planner.plan_config.llm.model_selected="/home/gridsan/DA32121/llm_shared/models/hub/models--deepseek-ai--DeepSeek-R1/snapshots/5a56bdbde75a16bdfbf3a8e9c852be3dfcfb8eef" \
    evaluation.agents.agent_1.planner.plan_config.llm.model_selected="/home/gridsan/DA32121/llm_shared/models/hub/models--deepseek-ai--DeepSeek-R1/snapshots/5a56bdbde75a16bdfbf3a8e9c852be3dfcfb8eef"
