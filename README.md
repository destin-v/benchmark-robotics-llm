<figure>
    <p align="center">
    <img src="docs/pics/program_logo.png" alt="drawing" width="200"/>
    </p>
</figure>

# Evaluation of Habitat Robotics using Large Language Models

<div align="center">
  <a href="https://arxiv.org/abs/2507.06157v1">   <img src="https://img.shields.io/badge/Paper-red?style=for-the-badge&logo=README&logoColor=white"></a>
  <a href="https://destin-v.github.io/benchmark-robotics-llm-paper/">   <img src="https://img.shields.io/badge/Website-blue?style=for-the-badge&logo=htmx&logoColor=white"></a>
</div>

<p align="center">
  <a href="https://devguide.python.org/versions/">                  <img alt="" src="https://img.shields.io/badge/python-3.9-blue?logo=python&logoColor=white"></a>
  <a href="https://github.com/pre-commit/pre-commit">               <img alt="" src="https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit"></a>
  <a href="https://docs.pytest.org/en/7.1.x/getting-started.html">  <img alt="" src="https://img.shields.io/badge/pytest-enabled-brightgreen?logo=pytest&logoColor=white"></a>
  <a href="https://black.readthedocs.io/en/stable/index.html">      <img alt="" src="https://badgen.net/static/code%20style/black/black"></a>
</p>

# 🤔 Description
This is a fork of the PARTNR benchmark.  The original PARTNR benchmark was designed to run with Llama. This repo adds a script called `run_experiments.py` which allows users to benchmark agents from API providers that follow the OpenAI interface.

# 🗺️ Information Flow
Below is a figure showing the flow of information through decentralized planners in PARTNR. Please note that there is no explicit communication between the two decentralized planners. The [Environment Interface](./habitat_llm/agent/env/environment_interface.py) reads observations for each agent and sends them to the [Perception Module](./habitat_llm/perception/perception_sim.py). The processed observations are used to update the [World Graph](./habitat_llm/world_model/world_graph.py) and the [Planner](./habitat_llm/planner/planner.py) (based on an LLM or other system) uses the world graph and the task description to select a [Tool](./habitat_llm/tools/tool.py) to interact with the environment.

<p align="center">
  <img src="docs/planner_v3.png" width="65%"/>
</p>

# 🛠️ Requirements
A GPU is required.  Tested on RTX 4090.



# 🏎️ Quickstart
Everything is provided for you in a container.

On host:

```bash
# Setup your OpenAI API keys prior to starting.
export OPENAI_API_KEY="..."

# Create a directory to save your experiments.
mkdir outputs

# Pull container and enter it. The container is >50GB!
podman run -it --rm \
  --env OPENAI_API_KEY \
  -v outputs:/root/benchmark-robotics-llm/outputs \
  --device nvidia.com/gpu=all \
  ghcr.io/destin-v/benchmark-robotics-llm
```

Inside container:

```bash
# Run OpenAI models with PARTNR randomly generated environments using:
#
# [x] partially observable environments
# [x] fully observable environments
# [x] centralized planners
# [x] decentralized planners

micromamba activate myenv 

python run_experiments.py
```

Outputs will be saved to the `outputs` folder on your host machine.  To view results run: 
```bash
# Run the preconfigured experiments.
python scripts/read_results.py <output_dir>/<dataset_name>
```

They will be labeled with `full`/`partial` observability and `centralized`/`decentralized` planning.

# 🥘 Custom Models
You can easily edit the `run_experiments.py` file to test a different model:

```python
 if __name__ == "__main__":
     """This needs to be run in a terminal."""
 
     # Start timer.
     timeout: int = 360 # modify this to extend the test time
     start_time: float = time.time()
     final_time: float = time.time()
 
     processes: list[Popen] = []
 
     # Non-reasoning models
     processes.extend(test_runner("gpt-4o")) # set your desired models
     processes.extend(test_runner("gpt-4.1")) # set your desired models
 
     # Reasoning models
     processes.extend(test_runner("o1")) # set your desired models
     processes.extend(test_runner("o3")) # set your desired models
     processes.extend(test_runner("o3-mini")) # set your desired models
 
     # Wait until timeout.
     while abs(final_time - start_time) < timeout:
         final_time: float = time.time()
         time.sleep(1)
 
     # Kill all processes.
     for process in processes:
         process.kill()
     print("Timeout Reached!")
     
```

# Ollama Server
Use Ollama to host local models. Steps:

1. Download [Ollama](https://ollama.com/download).
2. Download a [model](https://ollama.com/library).
3. Modify script to use Ollama (instructions below).

From inside your container:
```bash
ollama serve # start server
ollama pull gpt-oss:20b # pull a model
```

Edit the file: `habitat_llm/llm/openai_chat.py`:

```python
# line 65
self.client = OpenAI(
    base_url="http://localhost:11434/v1",  # Local Ollama API
    api_key="ollama"                       # Dummy key
)  
```



# 🐛 Troubleshooting
If you get an error stating that `proxies` does not exist, this is a bug in the OpenAI package.  Fix it by performing the following:

* Open: `/root/micromamba/envs/myenv/lib/python3.9/site-packages/openai/_base_client.py`
* Go to line: 773
* Replace: `proxies` with `proxy`

Save the edited file and now run: `python run_experiments.py`.

# 👷🏻 Installation
For manual installation **(not recommended)**, refer to [INSTALLATION.md](INSTALLATION.md)

# 📑 Citation
If you use our codebase or dataset in your research, please cite the [PARTNR](https://arxiv.org/pdf/2411.00081) paper and us:

```
@inproceedings{Habitat-LLM-Benchmarks,
    author = {William Li and Lei Hamilton and Kaise Al-natour and Sanjeev Mohindra},
    title = {Evaluation of Habitat Robotics using Large Language Models},
    booktitle = {Institute of Electrical and Electronics Engineers (IEEE)},
    year = {2025}}
```
