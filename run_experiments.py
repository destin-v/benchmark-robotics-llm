import signal
from contextlib import contextmanager
from subprocess import run


class TimeoutException(Exception):
    pass


@contextmanager
def time_limit(seconds):
    def signal_handler(signum, frame):
        raise TimeoutException("Timed out!")

    signal.signal(signal.SIGALRM, signal_handler)
    signal.alarm(seconds)
    try:
        yield
    finally:
        signal.alarm(0)


def run_centralized_hf(
    config: str,
    output_dir: str,
    data_path: str,
    model: str,
    timeout: int = 3600,
):
    try:
        with time_limit(timeout):
            run(
                args=[
                    "python",
                    "-m",
                    "habitat_llm.examples.planner_demo",
                    "--config-name",
                    config,
                    f'habitat.dataset.data_path="{data_path}"',
                    "evaluation.planner.plan_config.llm.inference_mode=hf",
                    f"evaluation.planner.plan_config.llm.generation_params.engine={model}",
                ],
            )
    except TimeoutException:
        print("Timed out!")


def run_decentralized_hf(
    config: str,
    output_dir: str,
    data_path: str,
    model: str,
    timeout: int = 3600,
):
    try:
        with time_limit(timeout):
            run(
                [
                    "python",
                    "-m",
                    "habitat_llm.examples.planner_demo",
                    "--config-name",
                    config,
                    f'habitat.dataset.data_path="{data_path}"',
                    "evaluation.agents.agent_0.planner.plan_config.llm.inference_mode=hf",
                    "evaluation.agents.agent_1.planner.plan_config.llm.inference_mode=hf",
                    f"evaluation.agents.agent_0.planner.plan_config.llm.generation_params.engine={model}",
                    f"evaluation.agents.agent_1.planner.plan_config.llm.generation_params.engine={model}",
                ],
            )
    except TimeoutException:
        print("Timed out!")


def run_centralized_chatgpt(
    config: str,
    data_path: str,
    model: str,
    timeout: int = 3600,
):
    try:
        with time_limit(timeout):
            run(
                [
                    "python",
                    "-m",
                    "habitat_llm.examples.planner_demo",
                    "--config-name",
                    config,
                    f'habitat.dataset.data_path="{data_path}"',
                    "llm@evaluation.agents.agent_0.planner.plan_config.llm={model}",
                    "llm@evaluation.agents.agent_1.planner.plan_config.llm={model}",
                ]
            )
    except TimeoutException:
        print("Timed out!")


def run_decentralized_chatgpt(
    config: str,
    data_path: str,
    model: str,
    timeout: int = 3600,
):
    try:
        with time_limit(timeout):
            run(
                [
                    "python",
                    "-m",
                    "habitat_llm.examples.planner_demo",
                    "--config-name",
                    config,
                    f'habitat.dataset.data_path="{data_path}"',
                    "llm@evaluation.agents.agent_0.planner.plan_config.llm={model}",
                    "llm@evaluation.agents.agent_1.planner.plan_config.llm={model}",
                ]
            )
    except TimeoutException:
        print("Timed out!")


def runner_hf(configs: list[str], ouput_dirs: list[str], data_id: str, model_id: str):
    data_paths: list[str] = [data_id] * len(configs)
    models: list[str] = [model_id] * len(configs)

    for config, output_dir, data_path, model in zip(
        configs, ouput_dirs, data_paths, models
    ):
        if "centralized" in config:
            run_centralized_hf(config, output_dir, data_path, model)
            continue

        if "decentralized" in config:
            run_decentralized_hf(config, output_dir, data_path, model)
            continue

        raise ValueError("Invalid config: {config}")


def runner_chatgpt(
    configs: list[str],
    output_dir: list[str],
    data_id: str,
    model_id: str,
):
    data_paths: list[str] = [data_id] * len(configs)
    models: list[str] = [model_id] * len(configs)

    for config, data_path, model in zip(configs, data_paths, models):
        if "centralized" in config:
            run_centralized_chatgpt(config, data_path, model)
            continue

        if "decentralized" in config:
            run_decentralized_chatgpt(config, data_path, model)
            continue

        raise ValueError("Invalid config: {config}")


if __name__ == "__main__":
    configs: list[str] = [
        # Centralized test points.
        "experiments/centralized_zero_shot_react_full_obs_summary.yaml",
        "experiments/centralized_zero_shot_react_partial_obs_summary.yaml",
        # Decentralized test points.
        "experiments/decentralized_zero_shot_react_full_obs_summary.yaml",
        "experiments/decentralized_zero_shot_react_partial_obs_summary.yaml",
    ]

    output_dirs: list[str] = [
        "outputs/central_zero_shot_full_obs",
        "outputs/central_zero_shot_partial_obs",
        "outputs/decentral_zero_shot_full_obs",
        "outputs/decentral_zero_shot_partial_obs",
    ]

    data_id: str = "data/datasets/partnr_episodes/v0_0/val_mini.json.gz"

    # Mistral
    model_id1: str = "mistralai/Mistral-7B-Instruct-v0.3"
    model_id2: str = "deepseek-ai/DeepSeek-R1-Distill-Llama-8B"
    model_id3: str = "openai_chat"

    # Runners
    runner_hf(configs, output_dirs, data_id, model_id1)  # mistral
    runner_hf(configs, output_dirs, data_id, model_id2)  # deepseek-8B
    runner_chatgpt(configs, output_dirs, data_id, model_id3)  # openai-chat
