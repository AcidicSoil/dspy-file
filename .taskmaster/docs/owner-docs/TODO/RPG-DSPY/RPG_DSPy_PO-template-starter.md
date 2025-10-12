[Directive]
Objective: Propose a clean integration of the DSPy framework with the Repository Planning Graph (RPG).
Inputs: {RPG_graph_pdf}, {current_repo_root}, {target_use_case}, {models_available}, {constraints_budget_time}.
Tasks:

1) Extract RPG nodes and edges. Label each node with a DSPy construct {Signature|Module|Program|Tool|Optimizer} and each edge with {data_flow|control_flow|feedback}.
2) Produce a system architecture diagram mapping RPG → DSPy modules. Include IO schemas and model boundaries.
3) Draft a minimal DSPy program skeleton that instantiates the mapped modules, wires tools, and enables one optimizer pass.
4) Define evaluation: {metric}, {devset_source}, pass-fail thresholds, and traceability plan.
Deliverables:

- Mapping table: node → DSPy construct, IO spec, owner.
- Architecture diagram and data-flow brief.
- Python skeleton with TODOs and docstrings.
- Evaluation plan with acceptance_criteria.
Constraints: keep to {N} modules, single optimizer {MIPROv2|BootstrapFewShot}, and enable MLflow or equivalent tracing.
