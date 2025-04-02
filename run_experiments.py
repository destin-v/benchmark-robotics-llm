import os
import time
from subprocess import Popen

# Environment variables
os.environ["QT_QPA_PLATFORM"] = "offscreen"

# Types
TYPE_PLANNER: list[str] = ["centralized", "decentralized"]


def execute_cmd(command: list[str]) -> Popen:
    process = Popen(command)

    return process


def runner_huggingface(
    config: str,
    output_dir: str,
    data_path: str,
    model: str,
    planner: str = "centralized",
) -> Popen:
    """Runner for HuggingFace models."""

    if planner not in TYPE_PLANNER:
        raise ValueError(f"Invalid planner: {planner}")

    if planner == "centralized":
        command: list[str] = [
            "python",
            "-m",
            "habitat_llm.examples.planner_demo",
            "--config-name",
            config,
            f'paths.results_dir="{output_dir}"',
            f'habitat.dataset.data_path="{data_path}"',
            "evaluation.planner.plan_config.llm.inference_mode=hf",
            f"evaluation.planner.plan_config.llm.generation_params.engine={model}",
        ]

    if planner == "decentralized":
        command: list[str] = [
            "python",
            "-m",
            "habitat_llm.examples.planner_demo",
            "--config-name",
            config,
            f'paths.results_dir="{output_dir}"',
            f'habitat.dataset.data_path="{data_path}"',
            "evaluation.agents.agent_0.planner.plan_config.llm.inference_mode=hf",
            "evaluation.agents.agent_1.planner.plan_config.llm.inference_mode=hf",
            f"evaluation.agents.agent_0.planner.plan_config.llm.generation_params.engine={model}",
            f"evaluation.agents.agent_1.planner.plan_config.llm.generation_params.engine={model}",
        ]

    process = execute_cmd(command)
    return process


def run_openai(
    config: str,
    output_dir: str,
    data_path: str,
    model: str,
    planner: str = "centralized",
) -> Popen:
    """Runner for OpenAI API."""

    if planner not in TYPE_PLANNER:
        raise ValueError(f"Invalid planner: {planner}")

    if planner == "centralized":
        command: list[str] = [
            "python",
            "-m",
            "habitat_llm.examples.planner_demo",
            "--config-name",
            config,
            f'paths.results_dir="{output_dir}"',
            f'habitat.dataset.data_path="{data_path}"',
            "llm@evaluation.planner.plan_config.llm=openai_chat",
            f'evaluation.planner.plan_config.llm.model_selected="{model}"',
        ]

    if planner == "decentralized":
        command: list[str] = [
            "python",
            "-m",
            "habitat_llm.examples.planner_demo",
            "--config-name",
            config,
            f'paths.results_dir="{output_dir}"',
            f'habitat.dataset.data_path="{data_path}"',
            "llm@evaluation.agents.agent_0.planner.plan_config.llm=openai_chat",
            "llm@evaluation.agents.agent_1.planner.plan_config.llm=openai_chat",
            f'evaluation.agents.agent_0.planner.plan_config.llm.model_selected="{model}"',
            f'evaluation.agents.agent_1.planner.plan_config.llm.model_selected="{model}"',
        ]

    process = execute_cmd(command)
    return process


def runner_hf(
    configs: list[str],
    ouput_dirs: list[str],
    data_id: str,
    model_id: str,
) -> list[Popen]:
    """Runner for HuggingFace models."""

    data_paths: list[str] = [data_id] * len(configs)
    models: list[str] = [model_id] * len(configs)
    processes: list[Popen] = []

    for config, output_dir, data_path, model in zip(
        configs, ouput_dirs, data_paths, models
    ):
        # Determine the planner type.
        if config.startswith("experiments/decentralized"):
            planner = "decentralized"
        if config.startswith("experiments/centralized"):
            planner = "centralized"

        processes.append(
            runner_huggingface(config, output_dir, data_path, model, planner)
        )

    return processes


def runner_openai(
    configs: list[str],
    output_dirs: list[str],
    data_id: str,
    model_id: str,
) -> list[Popen]:
    """Runner for OpenAI API."""

    data_paths: list[str] = [data_id] * len(configs)
    models: list[str] = [model_id] * len(configs)
    processes: list[Popen] = []

    for config, output_dir, data_path, model in zip(
        configs, output_dirs, data_paths, models
    ):
        # Determine the planner type.
        if config.startswith("experiments/decentralized"):
            planner = "decentralized"
        if config.startswith("experiments/centralized"):
            planner = "centralized"

        processes.append(run_openai(config, output_dir, data_path, model, planner))

    return processes


def get_test_configs() -> list[str]:
    """Standard configurations for testing zero-shot."""

    configs: list[str] = [
        # Centralized test points.
        "experiments/centralized_zero_shot_full_obs.yaml",
        "experiments/centralized_zero_shot_part_obs.yaml",
        # Decentralized test points.
        "experiments/decentralized_zero_shot_full_obs.yaml",
        "experiments/decentralized_zero_shot_part_obs.yaml",
    ]
    return configs


def test_runner(model_id: str) -> list[Popen]:
    """Test runner."""

    configs = get_test_configs()

    output_dirs: list[str] = [
        # Centralized test points.
        f"outputs/central_zero_shot_full_obs/{model_id}",
        f"outputs/central_zero_shot_part_obs/{model_id}",
        # Decentralized test points.
        f"outputs/decentral_zero_shot_full_obs/{model_id}",
        f"outputs/decentral_zero_shot_part_obs/{model_id}",
    ]

    data_id: str = "data/datasets/partnr_episodes/v0_0/val_mini.json.gz"

    processes = runner_openai(configs, output_dirs, data_id, model_id)
    return processes


if __name__ == "__main__":
    """This needs to be run in a terminal.  VsCode will crash after a few mins."""

    # Start timer.
    timeout: int = 360
    start_time: float = time.time()
    final_time: float = time.time()

    processes: list[Popen] = []

    # Non-reasoning models
    processes.extend(test_runner("gpt-4o"))
    processes.extend(test_runner("gpt-4.1"))

    # Reasoning models
    processes.extend(test_runner("o1"))
    processes.extend(test_runner("o3"))
    processes.extend(test_runner("o3-mini"))

    # Wait until timeout.
    while abs(final_time - start_time) < timeout:
        final_time: float = time.time()
        time.sleep(1)

    # Kill all processes.
    for process in processes:
        process.kill()
    print("Timeout Reached!")
