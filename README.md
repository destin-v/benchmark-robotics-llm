<figure>
    <p align="center">
    <img src="docs/pics/program_logo.png" alt="drawing" width="200"/>
    </p>
</figure>

# Evaluation of Habitat Robotics using Large Language Models

<div align="center">
  <a href="WEBSITE LINK">   <img src="https://img.shields.io/badge/Paper-red?style=for-the-badge&logo=README&logoColor=white"></a>
  <a href="https://destin-v.github.io/paper-benchmark-robotics-llm/">   <img src="https://img.shields.io/badge/Website-blue?style=for-the-badge&logo=htmx&logoColor=white"></a>
</div>

<p align="center">
  <a href="https://devguide.python.org/versions/">                  <img alt="" src="https://img.shields.io/badge/python-3.9-blue?logo=python&logoColor=white"></a>
  <a href="https://github.com/pre-commit/pre-commit">               <img alt="" src="https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit"></a>
  <a href="https://docs.pytest.org/en/7.1.x/getting-started.html">  <img alt="" src="https://img.shields.io/badge/pytest-enabled-brightgreen?logo=pytest&logoColor=white"></a>
  <a href="https://black.readthedocs.io/en/stable/index.html">      <img alt="" src="https://badgen.net/static/code%20style/black/black"></a>
</p>

# Description
This is a fork of the PARTNR benchmark.  The original PARTNR benchmark was designed to run with Llama. This repo adds a script called `run_experiments.py` which allows users to benchmark agents from API providers that follow the OpenAI interface.

# Information Flow
Below is a figure showing the flow of information through decentralized planners in PARTNR. Please note that there is no explicit communication between the two decentralized planners. The [Environment Interface](./habitat_llm/agent/env/environment_interface.py) reads observations for each agent and sends them to the [Perception Module](./habitat_llm/perception/perception_sim.py). The processed observations are used to update the [World Graph](./habitat_llm/world_model/world_graph.py) and the [Planner](./habitat_llm/planner/planner.py) (based on an LLM or other system) uses the world graph and the task description to select a [Tool](./habitat_llm/tools/tool.py) to interact with the environment.

<p align="center">
  <img src="docs/planner_v3.png" width="65%"/>
</p>

# Requirements
A GPU is required.  Tested on RTX 4090.

# Installation
For installation, refer to [INSTALLATION.md](INSTALLATION.md)

# Quickstart
```bash
python run_experiments.py
```

# Citation
If you use our codebase or dataset in your research, please cite the [PARTNR](https://arxiv.org/pdf/2411.00081) paper and us:

```
@inproceedings{Habitat-LLM-Benchmarks,
    author = {William Li and Lei Hamilton and Kaise Al-natour and Sanjeev Mohindra},
    title = {Evaluation of Habitat Robotics using Large Language Models},
    booktitle = {Institute of Electrical and Electronics Engineers (IEEE)},
    year = {2025}}
```
