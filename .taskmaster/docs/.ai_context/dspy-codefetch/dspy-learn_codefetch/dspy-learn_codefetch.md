Project Structure:
├── evaluation
│   ├── data.md
│   ├── metrics.md
│   └── overview.md
├── figures
│   ├── native_tool_call.png
│   └── teleprompter-classes.png
├── index.md
├── optimization
│   ├── optimizers.md
│   └── overview.md
└── programming
    ├── 7-assertions.md
    ├── adapters.md
    ├── language_models.md
    ├── modules.md
    ├── overview.md
    ├── signatures.md
    └── tools.md


index.md
```
1 | ---
2 | sidebar_position: 1
3 | ---
4 | 
5 | # Learning DSPy: An Overview
6 | 
7 | DSPy exposes a very small API that you can learn quickly. However, building a new AI system is a more open-ended journey of iterative development, in which you compose the tools and design patterns of DSPy to optimize for _your_ objectives. The three stages of building AI systems in DSPy are:
8 | 
9 | 1) **DSPy Programming.** This is about defining your task, its constraints, exploring a few examples, and using that to inform your initial pipeline design.
10 | 
11 | 2) **DSPy Evaluation.** Once your system starts working, this is the stage where you collect an initial development set, define your DSPy metric, and use these to iterate on your system more systematically.
12 | 
13 | 3) **DSPy Optimization.** Once you have a way to evaluate your system, you use DSPy optimizers to tune the prompts or weights in your program.
14 | 
15 | We suggest learning and applying DSPy in this order. For example, it's unproductive to launch optimization runs using a poorly designed program or a bad metric.
```

evaluation/data.md
```
1 | ---
2 | sidebar_position: 5
3 | ---
4 | 
5 | # Data
6 | 
7 | DSPy is a machine learning framework, so working in it involves training sets, development sets, and test sets. For each example in your data, we distinguish typically between three types of values: the inputs, the intermediate labels, and the final label. You can use DSPy effectively without any intermediate or final labels, but you will need at least a few example inputs.
8 | 
9 | 
10 | ## DSPy `Example` objects
11 | 
12 | The core data type for data in DSPy is `Example`. You will use **Examples** to represent items in your training set and test set. 
13 | 
14 | DSPy **Examples** are similar to Python `dict`s but have a few useful utilities. Your DSPy modules will return values of the type `Prediction`, which is a special sub-class of `Example`.
15 | 
16 | When you use DSPy, you will do a lot of evaluation and optimization runs. Your individual datapoints will be of type `Example`:
17 | 
18 | ```python
19 | qa_pair = dspy.Example(question="This is a question?", answer="This is an answer.")
20 | 
21 | print(qa_pair)
22 | print(qa_pair.question)
23 | print(qa_pair.answer)
24 | ```
25 | **Output:**
26 | ```text
27 | Example({'question': 'This is a question?', 'answer': 'This is an answer.'}) (input_keys=None)
28 | This is a question?
29 | This is an answer.
30 | ```
31 | 
32 | Examples can have any field keys and any value types, though usually values are strings.
33 | 
34 | ```text
35 | object = Example(field1=value1, field2=value2, field3=value3, ...)
36 | ```
37 | 
38 | You can now express your training set for example as:
39 | 
40 | ```python
41 | trainset = [dspy.Example(report="LONG REPORT 1", summary="short summary 1"), ...]
42 | ```
43 | 
44 | 
45 | ### Specifying Input Keys
46 | 
47 | In traditional ML, there are separated "inputs" and "labels".
48 | 
49 | In DSPy, the `Example` objects have a `with_inputs()` method, which can mark specific fields as inputs. (The rest are just metadata or labels.)
50 | 
51 | ```python
52 | # Single Input.
53 | print(qa_pair.with_inputs("question"))
54 | 
55 | # Multiple Inputs; be careful about marking your labels as inputs unless you mean it.
56 | print(qa_pair.with_inputs("question", "answer"))
57 | ```
58 | 
59 | Values can be accessed using the `.`(dot) operator. You can access the value of key `name` in defined object `Example(name="John Doe", job="sleep")` through `object.name`. 
60 | 
61 | To access or exclude certain keys, use `inputs()` and `labels()` methods to return new Example objects containing only input or non-input keys, respectively.
62 | 
63 | ```python
64 | article_summary = dspy.Example(article= "This is an article.", summary= "This is a summary.").with_inputs("article")
65 | 
66 | input_key_only = article_summary.inputs()
67 | non_input_key_only = article_summary.labels()
68 | 
69 | print("Example object with Input fields only:", input_key_only)
70 | print("Example object with Non-Input fields only:", non_input_key_only)
71 | ```
72 | 
73 | **Output**
74 | ```
75 | Example object with Input fields only: Example({'article': 'This is an article.'}) (input_keys={'article'})
76 | Example object with Non-Input fields only: Example({'summary': 'This is a summary.'}) (input_keys=None)
77 | ```
78 | 
79 | <!-- ## Loading Dataset from sources
80 | 
81 | One of the most convenient way to import datasets in DSPy is by using `DataLoader`. The first step is to declare an object, this object can then be used to call utilities to load datasets in different formats:
82 | 
83 | ```python
84 | from dspy.datasets import DataLoader
85 | 
86 | dl = DataLoader()
87 | ```
88 | 
89 | For most dataset formats, it's quite straightforward you pass the file path to the corresponding method of the format and you'll get the list of `Example` for the dataset in return:
90 | 
91 | ```python
92 | import pandas as pd
93 | 
94 | csv_dataset = dl.from_csv(
95 |     "sample_dataset.csv",
96 |     fields=("instruction", "context", "response"),
97 |     input_keys=("instruction", "context")
98 | )
99 | 
100 | json_dataset = dl.from_json(
101 |     "sample_dataset.json",
102 |     fields=("instruction", "context", "response"),
103 |     input_keys=("instruction", "context")
104 | )
105 | 
106 | parquet_dataset = dl.from_parquet(
107 |     "sample_dataset.parquet",
108 |     fields=("instruction", "context", "response"),
109 |     input_keys=("instruction", "context")
110 | )
111 | 
112 | pandas_dataset = dl.from_pandas(
113 |     pd.read_csv("sample_dataset.csv"),    # DataFrame
114 |     fields=("instruction", "context", "response"),
115 |     input_keys=("instruction", "context")
116 | )
117 | ```
118 | 
119 | These are some formats that `DataLoader` supports to load from file directly. In the backend, most of these methods leverage the `load_dataset` method from `datasets` library to load these formats. But when working with text data you often use HuggingFace datasets, in order to import HF datasets in list of `Example` format we can use `from_huggingface` method:
120 | 
121 | ```python
122 | blog_alpaca = dl.from_huggingface(
123 |     "intertwine-expel/expel-blog",
124 |     input_keys=("title",)
125 | )
126 | ```
127 | 
128 | You can access the splits of the dataset by accessing the corresponding key:
129 | 
130 | ```python
131 | train_split = blog_alpaca['train']
132 | 
133 | # Since this is the only split in the dataset we can split this into 
134 | # train and test split ourselves by slicing or sampling 75 rows from the train
135 | # split for testing.
136 | testset = train_split[:75]
137 | trainset = train_split[75:]
138 | ```
139 | 
140 | The way you load a HuggingFace dataset using `load_dataset` is exactly how you load data it via `from_huggingface` as well. This includes passing specific splits, subsplits, read instructions, etc. For code snippets, you can refer to the [cheatsheet snippets](/cheatsheet/#dspy-dataloaders) for loading from HF. -->
```

evaluation/metrics.md
```
1 | ---
2 | sidebar_position: 5
3 | ---
4 | 
5 | # Metrics
6 | 
7 | DSPy is a machine learning framework, so you must think about your **automatic metrics** for evaluation (to track your progress) and optimization (so DSPy can make your programs more effective).
8 | 
9 | 
10 | ## What is a metric and how do I define a metric for my task?
11 | 
12 | A metric is just a function that will take examples from your data and the output of your system and return a score that quantifies how good the output is. What makes outputs from your system good or bad? 
13 | 
14 | For simple tasks, this could be just "accuracy" or "exact match" or "F1 score". This may be the case for simple classification or short-form QA tasks.
15 | 
16 | However, for most applications, your system will output long-form outputs. There, your metric should probably be a smaller DSPy program that checks multiple properties of the output (quite possibly using AI feedback from LMs).
17 | 
18 | Getting this right on the first try is unlikely, but you should start with something simple and iterate. 
19 | 
20 | 
21 | ## Simple metrics
22 | 
23 | A DSPy metric is just a function in Python that takes `example` (e.g., from your training or dev set) and the output `pred` from your DSPy program, and outputs a `float` (or `int` or `bool`) score.
24 | 
25 | Your metric should also accept an optional third argument called `trace`. You can ignore this for a moment, but it will enable some powerful tricks if you want to use your metric for optimization.
26 | 
27 | Here's a simple example of a metric that's comparing `example.answer` and `pred.answer`. This particular metric will return a `bool`.
28 | 
29 | ```python
30 | def validate_answer(example, pred, trace=None):
31 |     return example.answer.lower() == pred.answer.lower()
32 | ```
33 | 
34 | Some people find these utilities (built-in) convenient:
35 | 
36 | - `dspy.evaluate.metrics.answer_exact_match`
37 | - `dspy.evaluate.metrics.answer_passage_match`
38 | 
39 | Your metrics could be more complex, e.g. check for multiple properties. The metric below will return a `float` if `trace is None` (i.e., if it's used for evaluation or optimization), and will return a `bool` otherwise (i.e., if it's used to bootstrap demonstrations).
40 | 
41 | ```python
42 | def validate_context_and_answer(example, pred, trace=None):
43 |     # check the gold label and the predicted answer are the same
44 |     answer_match = example.answer.lower() == pred.answer.lower()
45 | 
46 |     # check the predicted answer comes from one of the retrieved contexts
47 |     context_match = any((pred.answer.lower() in c) for c in pred.context)
48 | 
49 |     if trace is None: # if we're doing evaluation or optimization
50 |         return (answer_match + context_match) / 2.0
51 |     else: # if we're doing bootstrapping, i.e. self-generating good demonstrations of each step
52 |         return answer_match and context_match
53 | ```
54 | 
55 | Defining a good metric is an iterative process, so doing some initial evaluations and looking at your data and outputs is key.
56 | 
57 | 
58 | ## Evaluation
59 | 
60 | Once you have a metric, you can run evaluations in a simple Python loop.
61 | 
62 | ```python
63 | scores = []
64 | for x in devset:
65 |     pred = program(**x.inputs())
66 |     score = metric(x, pred)
67 |     scores.append(score)
68 | ```
69 | 
70 | If you need some utilities, you can also use the built-in `Evaluate` utility. It can help with things like parallel evaluation (multiple threads) or showing you a sample of inputs/outputs and the metric scores.
71 | 
72 | ```python
73 | from dspy.evaluate import Evaluate
74 | 
75 | # Set up the evaluator, which can be re-used in your code.
76 | evaluator = Evaluate(devset=YOUR_DEVSET, num_threads=1, display_progress=True, display_table=5)
77 | 
78 | # Launch evaluation.
79 | evaluator(YOUR_PROGRAM, metric=YOUR_METRIC)
80 | ```
81 | 
82 | 
83 | ## Intermediate: Using AI feedback for your metric
84 | 
85 | For most applications, your system will output long-form outputs, so your metric should check multiple dimensions of the output using AI feedback from LMs.
86 | 
87 | This simple signature could come in handy.
88 | 
89 | ```python
90 | # Define the signature for automatic assessments.
91 | class Assess(dspy.Signature):
92 |     """Assess the quality of a tweet along the specified dimension."""
93 | 
94 |     assessed_text = dspy.InputField()
95 |     assessment_question = dspy.InputField()
96 |     assessment_answer: bool = dspy.OutputField()
97 | ```
98 | 
99 | For example, below is a simple metric that checks a generated tweet (1) answers a given question correctly and (2) whether it's also engaging. We also check that (3) `len(tweet) <= 280` characters.
100 | 
101 | ```python
102 | def metric(gold, pred, trace=None):
103 |     question, answer, tweet = gold.question, gold.answer, pred.output
104 | 
105 |     engaging = "Does the assessed text make for a self-contained, engaging tweet?"
106 |     correct = f"The text should answer `{question}` with `{answer}`. Does the assessed text contain this answer?"
107 |     
108 |     correct =  dspy.Predict(Assess)(assessed_text=tweet, assessment_question=correct)
109 |     engaging = dspy.Predict(Assess)(assessed_text=tweet, assessment_question=engaging)
110 | 
111 |     correct, engaging = [m.assessment_answer for m in [correct, engaging]]
112 |     score = (correct + engaging) if correct and (len(tweet) <= 280) else 0
113 | 
114 |     if trace is not None: return score >= 2
115 |     return score / 2.0
116 | ```
117 | 
118 | When compiling, `trace is not None`, and we want to be strict about judging things, so we will only return `True` if `score >= 2`. Otherwise, we return a score out of 1.0 (i.e., `score / 2.0`).
119 | 
120 | 
121 | ## Advanced: Using a DSPy program as your metric
122 | 
123 | If your metric is itself a DSPy program, one of the most powerful ways to iterate is to compile (optimize) your metric itself. That's usually easy because the output of the metric is usually a simple value (e.g., a score out of 5) so the metric's metric is easy to define and optimize by collecting a few examples.
124 | 
125 | 
126 | 
127 | ### Advanced: Accessing the `trace`
128 | 
129 | When your metric is used during evaluation runs, DSPy will not try to track the steps of your program.
130 | 
131 | But during compiling (optimization), DSPy will trace your LM calls. The trace will contain inputs/outputs to each DSPy predictor and you can leverage that to validate intermediate steps for optimization.
132 | 
133 | 
134 | ```python
135 | def validate_hops(example, pred, trace=None):
136 |     hops = [example.question] + [outputs.query for *_, outputs in trace if 'query' in outputs]
137 | 
138 |     if max([len(h) for h in hops]) > 100: return False
139 |     if any(dspy.evaluate.answer_exact_match_str(hops[idx], hops[:idx], frac=0.8) for idx in range(2, len(hops))): return False
140 | 
141 |     return True
142 | ```
```

evaluation/overview.md
```
1 | ---
2 | sidebar_position: 1
3 | ---
4 | 
5 | # Evaluation in DSPy
6 | 
7 | Once you have an initial system, it's time to **collect an initial development set** so you can refine it more systematically. Even 20 input examples of your task can be useful, though 200 goes a long way. Depending on your _metric_, you either just need inputs and no labels at all, or you need inputs and the _final_ outputs of your system. (You almost never need labels for the intermediate steps in your program in DSPy.) You can probably find datasets that are adjacent to your task on, say, HuggingFace datasets or in a naturally occurring source like StackExchange. If there's data whose licenses are permissive enough, we suggest you use them. Otherwise, you can label a few examples by hand or start deploying a demo of your system and collect initial data that way.
8 | 
9 | Next, you should **define your DSPy metric**. What makes outputs from your system good or bad? Invest in defining metrics and improving them incrementally over time; it's hard to consistently improve what you aren't able to define. A metric is a function that takes examples from your data and takes the output of your system, and returns a score. For simple tasks, this could be just "accuracy", e.g. for simple classification or short-form QA tasks. For most applications, your system will produce long-form outputs, so your metric will be a smaller DSPy program that checks multiple properties of the output. Getting this right on the first try is unlikely: start with something simple and iterate.
10 | 
11 | Now that you have some data and a metric, run development evaluations on your pipeline designs to understand their tradeoffs. Look at the outputs and the metric scores. This will probably allow you to spot any major issues, and it will define a baseline for your next steps.
12 | 
13 | 
14 | ??? "If your metric is itself a DSPy program..."
15 |     If your metric is itself a DSPy program, a powerful way to iterate is to optimize your metric itself. That's usually easy because the output of the metric is usually a simple value (e.g., a score out of 5), so the metric's metric is easy to define and optimize by collecting a few examples.
16 | 
```

programming/7-assertions.md
```
1 | # DSPy Assertions 
2 | 
3 | !!! warning "Assertions are deprecated and NOT supported. Please use the `dspy.Refine` module instead. (or dspy.Suggest)."
4 | 
5 | The content below is deprecated, and is scheduled to be removed.
6 | 
7 | ## Introduction
8 | 
9 | Language models (LMs) have transformed how we interact with machine learning, offering vast capabilities in natural language understanding and generation. However, ensuring these models adhere to domain-specific constraints remains a challenge. Despite the growth of techniques like fine-tuning or “prompt engineering”, these approaches are extremely tedious and rely on heavy, manual hand-waving to guide the LMs in adhering to specific constraints. Even DSPy's modularity of programming prompting pipelines lacks mechanisms to effectively and automatically enforce these constraints. 
10 | 
11 | To address this, we introduce DSPy Assertions, a feature within the DSPy framework designed to automate the enforcement of computational constraints on LMs. DSPy Assertions empower developers to guide LMs towards desired outcomes with minimal manual intervention, enhancing the reliability, predictability, and correctness of LM outputs.
12 | 
13 | ### dspy.Assert and dspy.Suggest API    
14 | 
15 | We introduce two primary constructs within DSPy Assertions:
16 | 
17 | - **`dspy.Assert`**:
18 |   - **Parameters**: 
19 |     - `constraint (bool)`: Outcome of Python-defined boolean validation check.
20 |     - `msg (Optional[str])`: User-defined error message providing feedback or correction guidance.
21 |     - `backtrack (Optional[module])`: Specifies target module for retry attempts upon constraint failure. The default backtracking module is the last module before the assertion.
22 |   - **Behavior**: Initiates retry  upon failure, dynamically adjusting the pipeline's execution. If failures persist, it halts execution and raises a `dspy.AssertionError`.
23 | 
24 | - **`dspy.Suggest`**:
25 |   - **Parameters**: Similar to `dspy.Assert`.
26 |   - **Behavior**: Encourages self-refinement through retries without enforcing hard stops. Logs failures after maximum backtracking attempts and continues execution.
27 | 
28 | - **dspy.Assert vs. Python Assertions**: Unlike conventional Python `assert` statements that terminate the program upon failure, `dspy.Assert` conducts a sophisticated retry mechanism, allowing the pipeline to adjust. 
29 | 
30 | Specifically, when a constraint is not met:
31 | 
32 | - Backtracking Mechanism: An under-the-hood backtracking is initiated, offering the model a chance to self-refine and proceed, which is done through signature modification.
33 | - Dynamic Signature Modification: internally modifying your DSPy program’s Signature by adding the following fields:
34 |     - Past Output: your model's past output that did not pass the validation_fn
35 |     - Instruction: your user-defined feedback message on what went wrong and what possibly to fix
36 | 
37 | If the error continues past the `max_backtracking_attempts`, then `dspy.Assert` will halt the pipeline execution, alerting you with an `dspy.AssertionError`. This ensures your program doesn't continue executing with “bad” LM behavior and immediately highlights sample failure outputs for user assessment.
38 | 
39 | - **dspy.Suggest vs. dspy.Assert**: `dspy.Suggest` on the other hand offers a softer approach. It maintains the same retry backtracking as `dspy.Assert` but instead serves as a gentle nudger. If the model outputs cannot pass the model constraints after the `max_backtracking_attempts`, `dspy.Suggest` will log the persistent failure and continue execution of the program on the rest of the data. This ensures the LM pipeline works in a "best-effort" manner without halting execution. 
40 | 
41 | - **`dspy.Suggest`** statements are best utilized as "helpers" during the evaluation phase, offering guidance and potential corrections without halting the pipeline.
42 | - **`dspy.Assert`** statements are recommended during the development stage as "checkers" to ensure the LM behaves as expected, providing a robust mechanism for identifying and addressing errors early in the development cycle.
43 | 
44 | 
45 | ## Use Case: Including Assertions in DSPy Programs
46 | 
47 | We start with using an example of a multi-hop QA SimplifiedBaleen pipeline as defined in the intro walkthrough. 
48 | 
49 | ```python
50 | class SimplifiedBaleen(dspy.Module):
51 |     def __init__(self, passages_per_hop=2, max_hops=2):
52 |         super().__init__()
53 | 
54 |         self.generate_query = [dspy.ChainOfThought(GenerateSearchQuery) for _ in range(max_hops)]
55 |         self.retrieve = dspy.Retrieve(k=passages_per_hop)
56 |         self.generate_answer = dspy.ChainOfThought(GenerateAnswer)
57 |         self.max_hops = max_hops
58 | 
59 |     def forward(self, question):
60 |         context = []
61 |         prev_queries = [question]
62 | 
63 |         for hop in range(self.max_hops):
64 |             query = self.generate_query[hop](context=context, question=question).query
65 |             prev_queries.append(query)
66 |             passages = self.retrieve(query).passages
67 |             context = deduplicate(context + passages)
68 |         
69 |         pred = self.generate_answer(context=context, question=question)
70 |         pred = dspy.Prediction(context=context, answer=pred.answer)
71 |         return pred
72 | 
73 | baleen = SimplifiedBaleen()
74 | 
75 | baleen(question = "Which award did Gary Zukav's first book receive?")
76 | ```
77 | 
78 | To include DSPy Assertions, we simply define our validation functions and declare our assertions following the respective model generation. 
79 | 
80 | For this use case, suppose we want to impose the following constraints:
81 |     1. Length - each query should be less than 100 characters
82 |     2. Uniqueness - each generated query should differ from previously-generated queries. 
83 |     
84 | We can define these validation checks as boolean functions:
85 | 
86 | ```python
87 | #simplistic boolean check for query length
88 | len(query) <= 100
89 | 
90 | #Python function for validating distinct queries
91 | def validate_query_distinction_local(previous_queries, query):
92 |     """check if query is distinct from previous queries"""
93 |     if previous_queries == []:
94 |         return True
95 |     if dspy.evaluate.answer_exact_match_str(query, previous_queries, frac=0.8):
96 |         return False
97 |     return True
98 | ```
99 | 
100 | We can declare these validation checks through `dspy.Suggest` statements (as we want to test the program in a best-effort demonstration). We want to keep these after the query generation `query = self.generate_query[hop](context=context, question=question).query`.
101 | 
102 | ```python
103 | dspy.Suggest(
104 |     len(query) <= 100,
105 |     "Query should be short and less than 100 characters",
106 |     target_module=self.generate_query
107 | )
108 | 
109 | dspy.Suggest(
110 |     validate_query_distinction_local(prev_queries, query),
111 |     "Query should be distinct from: "
112 |     + "; ".join(f"{i+1}) {q}" for i, q in enumerate(prev_queries)),
113 |     target_module=self.generate_query
114 | )
115 | ```
116 | 
117 | It is recommended to define a program with assertions separately than your original program if you are doing comparative evaluation for the effect of assertions. If not, feel free to set Assertions away!
118 | 
119 | Let's take a look at how the SimplifiedBaleen program will look with Assertions included:
120 | 
121 | ```python
122 | class SimplifiedBaleenAssertions(dspy.Module):
123 |     def __init__(self, passages_per_hop=2, max_hops=2):
124 |         super().__init__()
125 |         self.generate_query = [dspy.ChainOfThought(GenerateSearchQuery) for _ in range(max_hops)]
126 |         self.retrieve = dspy.Retrieve(k=passages_per_hop)
127 |         self.generate_answer = dspy.ChainOfThought(GenerateAnswer)
128 |         self.max_hops = max_hops
129 | 
130 |     def forward(self, question):
131 |         context = []
132 |         prev_queries = [question]
133 | 
134 |         for hop in range(self.max_hops):
135 |             query = self.generate_query[hop](context=context, question=question).query
136 | 
137 |             dspy.Suggest(
138 |                 len(query) <= 100,
139 |                 "Query should be short and less than 100 characters",
140 |                 target_module=self.generate_query
141 |             )
142 | 
143 |             dspy.Suggest(
144 |                 validate_query_distinction_local(prev_queries, query),
145 |                 "Query should be distinct from: "
146 |                 + "; ".join(f"{i+1}) {q}" for i, q in enumerate(prev_queries)),
147 |                 target_module=self.generate_query
148 |             )
149 | 
150 |             prev_queries.append(query)
151 |             passages = self.retrieve(query).passages
152 |             context = deduplicate(context + passages)
153 |         
154 |         if all_queries_distinct(prev_queries):
155 |             self.passed_suggestions += 1
156 | 
157 |         pred = self.generate_answer(context=context, question=question)
158 |         pred = dspy.Prediction(context=context, answer=pred.answer)
159 |         return pred
160 | ```
161 | 
162 | Now calling programs with DSPy Assertions requires one last step, and that is transforming the program to wrap it with internal assertions backtracking and Retry logic. 
163 | 
164 | ```python
165 | from dspy.primitives.assertions import assert_transform_module, backtrack_handler
166 | 
167 | baleen_with_assertions = assert_transform_module(SimplifiedBaleenAssertions(), backtrack_handler)
168 | 
169 | # backtrack_handler is parameterized over a few settings for the backtracking mechanism
170 | # To change the number of max retry attempts, you can do
171 | baleen_with_assertions_retry_once = assert_transform_module(SimplifiedBaleenAssertions(), 
172 |     functools.partial(backtrack_handler, max_backtracks=1))
173 | ```
174 | 
175 | Alternatively, you can also directly call `activate_assertions` on the program with `dspy.Assert/Suggest` statements using the default backtracking mechanism (`max_backtracks=2`):
176 | 
177 | ```python
178 | baleen_with_assertions = SimplifiedBaleenAssertions().activate_assertions()
179 | ```
180 | 
181 | Now let's take a look at the internal LM backtracking by inspecting the history of the LM query generations. Here we see that when a query fails to pass the validation check of being less than 100 characters, its internal `GenerateSearchQuery` signature is dynamically modified during the backtracking+Retry process to include the past query and the corresponding user-defined instruction: `"Query should be short and less than 100 characters"`.
182 | 
183 | 
184 | ```text
185 | Write a simple search query that will help answer a complex question.
186 | 
187 | ---
188 | 
189 | Follow the following format.
190 | 
191 | Context: may contain relevant facts
192 | 
193 | Question: ${question}
194 | 
195 | Reasoning: Let's think step by step in order to ${produce the query}. We ...
196 | 
197 | Query: ${query}
198 | 
199 | ---
200 | 
201 | Context:
202 | [1] «Kerry Condon | Kerry Condon (born 4 January 1983) is [...]»
203 | [2] «Corona Riccardo | Corona Riccardo (c. 1878October 15, 1917) was [...]»
204 | 
205 | Question: Who acted in the shot film The Shore and is also the youngest actress ever to play Ophelia in a Royal Shakespeare Company production of "Hamlet." ?
206 | 
207 | Reasoning: Let's think step by step in order to find the answer to this question. First, we need to identify the actress who played Ophelia in a Royal Shakespeare Company production of "Hamlet." Then, we need to find out if this actress also acted in the short film "The Shore."
208 | 
209 | Query: "actress who played Ophelia in Royal Shakespeare Company production of Hamlet" + "actress in short film The Shore"
210 | 
211 | 
212 | 
213 | Write a simple search query that will help answer a complex question.
214 | 
215 | ---
216 | 
217 | Follow the following format.
218 | 
219 | Context: may contain relevant facts
220 | 
221 | Question: ${question}
222 | 
223 | Past Query: past output with errors
224 | 
225 | Instructions: Some instructions you must satisfy
226 | 
227 | Query: ${query}
228 | 
229 | ---
230 | 
231 | Context:
232 | [1] «Kerry Condon | Kerry Condon (born 4 January 1983) is an Irish television and film actress, best known for her role as Octavia of the Julii in the HBO/BBC series "Rome," as Stacey Ehrmantraut in AMC's "Better Call Saul" and as the voice of F.R.I.D.A.Y. in various films in the Marvel Cinematic Universe. She is also the youngest actress ever to play Ophelia in a Royal Shakespeare Company production of "Hamlet."»
233 | [2] «Corona Riccardo | Corona Riccardo (c. 1878October 15, 1917) was an Italian born American actress who had a brief Broadway stage career before leaving to become a wife and mother. Born in Naples she came to acting in 1894 playing a Mexican girl in a play at the Empire Theatre. Wilson Barrett engaged her for a role in his play "The Sign of the Cross" which he took on tour of the United States. Riccardo played the role of Ancaria and later played Berenice in the same play. Robert B. Mantell in 1898 who struck by her beauty also cast her in two Shakespeare plays, "Romeo and Juliet" and "Othello". Author Lewis Strang writing in 1899 said Riccardo was the most promising actress in America at the time. Towards the end of 1898 Mantell chose her for another Shakespeare part, Ophelia im Hamlet. Afterwards she was due to join Augustin Daly's Theatre Company but Daly died in 1899. In 1899 she gained her biggest fame by playing Iras in the first stage production of Ben-Hur.»
234 | 
235 | Question: Who acted in the shot film The Shore and is also the youngest actress ever to play Ophelia in a Royal Shakespeare Company production of "Hamlet." ?
236 | 
237 | Past Query: "actress who played Ophelia in Royal Shakespeare Company production of Hamlet" + "actress in short film The Shore"
238 | 
239 | Instructions: Query should be short and less than 100 characters
240 | 
241 | Query: "actress Ophelia RSC Hamlet" + "actress The Shore"
242 | 
243 | ```
244 | 
245 | 
246 | ## Assertion-Driven Optimizations
247 | 
248 | DSPy Assertions work with optimizations that DSPy offers, particularly with `BootstrapFewShotWithRandomSearch`, including the following settings:
249 | 
250 | - Compilation with Assertions
251 |     This includes assertion-driven example bootstrapping and counterexample bootstrapping during compilation. The teacher model for bootstrapping few-shot demonstrations can make use of DSPy Assertions to offer robust bootstrapped examples for the student model to learn from during inference. In this setting, the student model does not perform assertion aware optimizations (backtracking and retry) during inference.
252 | - Compilation + Inference with Assertions
253 |     -This includes assertion-driven optimizations in both compilation and inference. Now the teacher model offers assertion-driven examples but the student can further optimize with assertions of its own during inference time. 
254 | ```python
255 | teleprompter = BootstrapFewShotWithRandomSearch(
256 |     metric=validate_context_and_answer_and_hops,
257 |     max_bootstrapped_demos=max_bootstrapped_demos,
258 |     num_candidate_programs=6,
259 | )
260 | 
261 | #Compilation with Assertions
262 | compiled_with_assertions_baleen = teleprompter.compile(student = baleen, teacher = baleen_with_assertions, trainset = trainset, valset = devset)
263 | 
264 | #Compilation + Inference with Assertions
265 | compiled_baleen_with_assertions = teleprompter.compile(student=baleen_with_assertions, teacher = baleen_with_assertions, trainset=trainset, valset=devset)
266 | 
267 | ```
```

programming/adapters.md
```
1 | # Understanding DSPy Adapters
2 | 
3 | ## What are Adapters?
4 | 
5 | Adapters are the bridge between `dspy.Predict` and the actual Language Model (LM). When you call a DSPy module, the
6 | adapter takes your signature, user inputs, and other attributes like `demos` (few-shot examples) and converts them
7 | into multi-turn messages that get sent to the LM.
8 | 
9 | The adapter system is responsible for:
10 | 
11 | - Translating DSPy signatures into system messages that define the task and request/response structure.
12 | - Formatting input data according to the request structure outlined in DSPy signatures.
13 | - Parsing LM responses back into structured DSPy outputs, such as `dspy.Prediction` instances.
14 | - Managing conversation history and function calls.
15 | - Converting pre-built DSPy types into LM prompt messages, e.g., `dspy.Tool`, `dspy.Image`, etc.
16 | 
17 | ## Configure Adapters
18 | 
19 | You can use `dspy.configure(adapter=...)` to choose the adapter for the entire Python process, or
20 | `with dspy.context(adapter=...):` to only affect a certain namespace.
21 | 
22 | If no adapter is specified in the DSPy workflow, each `dspy.Predict.__call__` defaults to using the `dspy.ChatAdapter`. Thus, the two code snippets below are equivalent:
23 | 
24 | ```python
25 | import dspy
26 | 
27 | dspy.configure(lm=dspy.LM("openai/gpt-4o-mini"))
28 | 
29 | predict = dspy.Predict("question -> answer")
30 | result = predict(question="What is the capital of France?")
31 | ```
32 | 
33 | ```python
34 | import dspy
35 | 
36 | dspy.configure(
37 |     lm=dspy.LM("openai/gpt-4o-mini"),
38 |     adapter=dspy.ChatAdapter(),  # This is the default value
39 | )
40 | 
41 | predict = dspy.Predict("question -> answer")
42 | result = predict(question="What is the capital of France?")
43 | ```
44 | 
45 | ## Where Adapters Fit in the System
46 | 
47 | The flow works as follows:
48 | 
49 | 1. The user calls their DSPy agent, typically a `dspy.Module` with inputs.
50 | 2. The inner `dspy.Predict` is invoked to obtain the LM response.
51 | 3. `dspy.Predict` calls **Adapter.format()**, which converts its signature, inputs, and demos into multi-turn messages sent to the `dspy.LM`. `dspy.LM` is a thin wrapper around `litellm`, which communicates with the LM endpoint.
52 | 4. The LM receives the messages and generates a response.
53 | 5. **Adapter.parse()** converts the LM response into structured DSPy outputs, as specified in the signature.
54 | 6. The caller of `dspy.Predict` receives the parsed outputs.
55 | 
56 | You can explicitly call `Adapter.format()` to view the messages sent to the LM.
57 | 
58 | ```python
59 | # Simplified flow example
60 | signature = dspy.Signature("question -> answer")
61 | inputs = {"question": "What is 2+2?"}
62 | demos = [{"question": "What is 1+1?", "answer": "2"}]
63 | 
64 | adapter = dspy.ChatAdapter()
65 | print(adapter.format(signature, demos, inputs))
66 | ```
67 | 
68 | The output should resemble:
69 | 
70 | ```
71 | {'role': 'system', 'content': 'Your input fields are:\n1. `question` (str):\nYour output fields are:\n1. `answer` (str):\nAll interactions will be structured in the following way, with the appropriate values filled in.\n\n[[ ## question ## ]]\n{question}\n\n[[ ## answer ## ]]\n{answer}\n\n[[ ## completed ## ]]\nIn adhering to this structure, your objective is: \n        Given the fields `question`, produce the fields `answer`.'}
72 | {'role': 'user', 'content': '[[ ## question ## ]]\nWhat is 1+1?'}
73 | {'role': 'assistant', 'content': '[[ ## answer ## ]]\n2\n\n[[ ## completed ## ]]\n'}
74 | {'role': 'user', 'content': '[[ ## question ## ]]\nWhat is 2+2?\n\nRespond with the corresponding output fields, starting with the field `[[ ## answer ## ]]`, and then ending with the marker for `[[ ## completed ## ]]`.'}
75 | ```
76 | 
77 | ## Types of Adapters
78 | 
79 | DSPy offers several adapter types, each tailored for specific use cases:
80 | 
81 | ### ChatAdapter
82 | 
83 | **ChatAdapter** is the default adapter and works with all language models. It uses a field-based format with special markers.
84 | 
85 | #### Format Structure
86 | 
87 | ChatAdapter uses `[[ ## field_name ## ]]` markers to delineate fields. For fields of non-primitive Python types, it includes the JSON schema of the type. Below, we use `dspy.inspect_history()` to display the formatted messages by `dspy.ChatAdapter` clearly.
88 | 
89 | ```python
90 | import dspy
91 | import pydantic
92 | 
93 | dspy.configure(lm=dspy.LM("openai/gpt-4o-mini"), adapter=dspy.ChatAdapter())
94 | 
95 | 
96 | class ScienceNews(pydantic.BaseModel):
97 |     text: str
98 |     scientists_involved: list[str]
99 | 
100 | 
101 | class NewsQA(dspy.Signature):
102 |     """Get news about the given science field"""
103 | 
104 |     science_field: str = dspy.InputField()
105 |     year: int = dspy.InputField()
106 |     num_of_outputs: int = dspy.InputField()
107 |     news: list[ScienceNews] = dspy.OutputField(desc="science news")
108 | 
109 | 
110 | predict = dspy.Predict(NewsQA)
111 | predict(science_field="Computer Theory", year=2022, num_of_outputs=1)
112 | dspy.inspect_history()
113 | ```
114 | 
115 | The output looks like:
116 | 
117 | ```
118 | [2025-08-15T22:24:29.378666]
119 | 
120 | System message:
121 | 
122 | Your input fields are:
123 | 1. `science_field` (str):
124 | 2. `year` (int):
125 | 3. `num_of_outputs` (int):
126 | Your output fields are:
127 | 1. `news` (list[ScienceNews]): science news
128 | All interactions will be structured in the following way, with the appropriate values filled in.
129 | 
130 | [[ ## science_field ## ]]
131 | {science_field}
132 | 
133 | [[ ## year ## ]]
134 | {year}
135 | 
136 | [[ ## num_of_outputs ## ]]
137 | {num_of_outputs}
138 | 
139 | [[ ## news ## ]]
140 | {news}        # note: the value you produce must adhere to the JSON schema: {"type": "array", "$defs": {"ScienceNews": {"type": "object", "properties": {"scientists_involved": {"type": "array", "items": {"type": "string"}, "title": "Scientists Involved"}, "text": {"type": "string", "title": "Text"}}, "required": ["text", "scientists_involved"], "title": "ScienceNews"}}, "items": {"$ref": "#/$defs/ScienceNews"}}
141 | 
142 | [[ ## completed ## ]]
143 | In adhering to this structure, your objective is:
144 |         Get news about the given science field
145 | 
146 | 
147 | User message:
148 | 
149 | [[ ## science_field ## ]]
150 | Computer Theory
151 | 
152 | [[ ## year ## ]]
153 | 2022
154 | 
155 | [[ ## num_of_outputs ## ]]
156 | 1
157 | 
158 | Respond with the corresponding output fields, starting with the field `[[ ## news ## ]]` (must be formatted as a valid Python list[ScienceNews]), and then ending with the marker for `[[ ## completed ## ]]`.
159 | 
160 | 
161 | Response:
162 | 
163 | [[ ## news ## ]]
164 | [
165 |     {
166 |         "scientists_involved": ["John Doe", "Jane Smith"],
167 |         "text": "In 2022, researchers made significant advancements in quantum computing algorithms, demonstrating their potential to solve complex problems faster than classical computers. This breakthrough could revolutionize fields such as cryptography and optimization."
168 |     }
169 | ]
170 | 
171 | [[ ## completed ## ]]
172 | ```
173 | 
174 | !!! info "Practice: locate Signature information in the printed LM history"
175 | 
176 |     Try adjusting the signature, and observe how the changes are reflected in the printed LM message.
177 | 
178 | 
179 | Each field is preceded by a marker `[[ ## field_name ## ]]`. If an output field has non-primitive types, the instruction includes the type's JSON schema, and the output is formatted accordingly. Because the output field is structured as defined by ChatAdapter, it can be automatically parsed into structured data.
180 | 
181 | #### When to Use ChatAdapter
182 | 
183 | `ChatAdapter` offers the following advantages:
184 | 
185 | - **Universal compatibility**: Works with all language models, though smaller models may generate responses that do not match the required format.
186 | - **Fallback protection**: If `ChatAdapter` fails, it automatically retries with `JSONAdapter`.
187 | 
188 | In general, `ChatAdapter` is a reliable choice if you don't have specific requirements.
189 | 
190 | #### When Not to Use ChatAdapter
191 | 
192 | Avoid using `ChatAdapter` if you are:
193 | 
194 | - **Latency sensitive**: `ChatAdapter` includes more boilerplate output tokens compared to other adapters, so if you're building a system sensitive to latency, consider using a different adapter.
195 | 
196 | ### JSONAdapter
197 | 
198 | **JSONAdapter** prompts the LM to return JSON data containing all output fields as specified in the signature. It is effective for models that support structured output via the `response_format` parameter, leveraging native JSON generation capabilities for more reliable parsing.
199 | 
200 | #### Format Structure
201 | 
202 | The input part of the prompt formatted by `JSONAdapter` is similar to `ChatAdapter`, but the output part differs, as shown below:
203 | 
204 | ```python
205 | import dspy
206 | import pydantic
207 | 
208 | dspy.configure(lm=dspy.LM("openai/gpt-4o-mini"), adapter=dspy.JSONAdapter())
209 | 
210 | 
211 | class ScienceNews(pydantic.BaseModel):
212 |     text: str
213 |     scientists_involved: list[str]
214 | 
215 | 
216 | class NewsQA(dspy.Signature):
217 |     """Get news about the given science field"""
218 | 
219 |     science_field: str = dspy.InputField()
220 |     year: int = dspy.InputField()
221 |     num_of_outputs: int = dspy.InputField()
222 |     news: list[ScienceNews] = dspy.OutputField(desc="science news")
223 | 
224 | 
225 | predict = dspy.Predict(NewsQA)
226 | predict(science_field="Computer Theory", year=2022, num_of_outputs=1)
227 | dspy.inspect_history()
228 | ```
229 | 
230 | ```
231 | System message:
232 | 
233 | Your input fields are:
234 | 1. `science_field` (str):
235 | 2. `year` (int):
236 | 3. `num_of_outputs` (int):
237 | Your output fields are:
238 | 1. `news` (list[ScienceNews]): science news
239 | All interactions will be structured in the following way, with the appropriate values filled in.
240 | 
241 | Inputs will have the following structure:
242 | 
243 | [[ ## science_field ## ]]
244 | {science_field}
245 | 
246 | [[ ## year ## ]]
247 | {year}
248 | 
249 | [[ ## num_of_outputs ## ]]
250 | {num_of_outputs}
251 | 
252 | Outputs will be a JSON object with the following fields.
253 | 
254 | {
255 |   "news": "{news}        # note: the value you produce must adhere to the JSON schema: {\"type\": \"array\", \"$defs\": {\"ScienceNews\": {\"type\": \"object\", \"properties\": {\"scientists_involved\": {\"type\": \"array\", \"items\": {\"type\": \"string\"}, \"title\": \"Scientists Involved\"}, \"text\": {\"type\": \"string\", \"title\": \"Text\"}}, \"required\": [\"text\", \"scientists_involved\"], \"title\": \"ScienceNews\"}}, \"items\": {\"$ref\": \"#/$defs/ScienceNews\"}}"
256 | }
257 | In adhering to this structure, your objective is:
258 |         Get news about the given science field
259 | 
260 | 
261 | User message:
262 | 
263 | [[ ## science_field ## ]]
264 | Computer Theory
265 | 
266 | [[ ## year ## ]]
267 | 2022
268 | 
269 | [[ ## num_of_outputs ## ]]
270 | 1
271 | 
272 | Respond with a JSON object in the following order of fields: `news` (must be formatted as a valid Python list[ScienceNews]).
273 | 
274 | 
275 | Response:
276 | 
277 | {
278 |   "news": [
279 |     {
280 |       "text": "In 2022, researchers made significant advancements in quantum computing algorithms, demonstrating that quantum systems can outperform classical computers in specific tasks. This breakthrough could revolutionize fields such as cryptography and complex system simulations.",
281 |       "scientists_involved": [
282 |         "Dr. Alice Smith",
283 |         "Dr. Bob Johnson",
284 |         "Dr. Carol Lee"
285 |       ]
286 |     }
287 |   ]
288 | }
289 | ```
290 | 
291 | #### When to Use JSONAdapter
292 | 
293 | `JSONAdapter` is good at:
294 | 
295 | - **Structured output support**: When the model supports the `response_format` parameter.
296 | - **Low latency**: Minimal boilerplate in the LM response results in faster responses.
297 | 
298 | #### When Not to Use JSONAdapter
299 | 
300 | Avoid using `JSONAdapter` if you are:
301 | 
302 | - Using a model that does not natively support structured output, such as a small open-source model hosted on Ollama.
303 | 
304 | ## Summary
305 | 
306 | Adapters are a crucial component of DSPy that bridge the gap between structured DSPy signatures and language model APIs.
307 | Understanding when and how to use different adapters will help you build more reliable and efficient DSPy programs.
```

programming/language_models.md
```
1 | ---
2 | sidebar_position: 2
3 | ---
4 | 
5 | # Language Models
6 | 
7 | The first step in any DSPy code is to set up your language model. For example, you can configure OpenAI's GPT-4o-mini as your default LM as follows.
8 | 
9 | ```python linenums="1"
10 | # Authenticate via `OPENAI_API_KEY` env: import os; os.environ['OPENAI_API_KEY'] = 'here'
11 | lm = dspy.LM('openai/gpt-4o-mini')
12 | dspy.configure(lm=lm)
13 | ```
14 | 
15 | !!! info "A few different LMs"
16 | 
17 |     === "OpenAI"
18 |         You can authenticate by setting the `OPENAI_API_KEY` env variable or passing `api_key` below.
19 | 
20 |         ```python linenums="1"
21 |         import dspy
22 |         lm = dspy.LM('openai/gpt-4o-mini', api_key='YOUR_OPENAI_API_KEY')
23 |         dspy.configure(lm=lm)
24 |         ```
25 | 
26 |     === "Gemini (AI Studio)"
27 |         You can authenticate by setting the GEMINI_API_KEY env variable or passing `api_key` below.
28 | 
29 |         ```python linenums="1"
30 |         import dspy
31 |         lm = dspy.LM('gemini/gemini-2.5-pro-preview-03-25', api_key='GEMINI_API_KEY')
32 |         dspy.configure(lm=lm)
33 |         ```
34 | 
35 |     === "Anthropic"
36 |         You can authenticate by setting the ANTHROPIC_API_KEY env variable or passing `api_key` below.
37 | 
38 |         ```python linenums="1"
39 |         import dspy
40 |         lm = dspy.LM('anthropic/claude-3-opus-20240229', api_key='YOUR_ANTHROPIC_API_KEY')
41 |         dspy.configure(lm=lm)
42 |         ```
43 | 
44 |     === "Databricks"
45 |         If you're on the Databricks platform, authentication is automatic via their SDK. If not, you can set the env variables `DATABRICKS_API_KEY` and `DATABRICKS_API_BASE`, or pass `api_key` and `api_base` below.
46 | 
47 |         ```python linenums="1"
48 |         import dspy
49 |         lm = dspy.LM('databricks/databricks-meta-llama-3-1-70b-instruct')
50 |         dspy.configure(lm=lm)
51 |         ```
52 | 
53 |     === "Local LMs on a GPU server"
54 |           First, install [SGLang](https://sgl-project.github.io/start/install.html) and launch its server with your LM.
55 | 
56 |           ```bash
57 |           > pip install "sglang[all]"
58 |           > pip install flashinfer -i https://flashinfer.ai/whl/cu121/torch2.4/ 
59 | 
60 |           > CUDA_VISIBLE_DEVICES=0 python -m sglang.launch_server --port 7501 --model-path meta-llama/Meta-Llama-3-8B-Instruct
61 |           ```
62 | 
63 |           Then, connect to it from your DSPy code as an OpenAI-compatible endpoint.
64 | 
65 |           ```python linenums="1"
66 |           lm = dspy.LM("openai/meta-llama/Meta-Llama-3-8B-Instruct",
67 |                            api_base="http://localhost:7501/v1",  # ensure this points to your port
68 |                            api_key="", model_type='chat')
69 |           dspy.configure(lm=lm)
70 |           ```
71 | 
72 |     === "Local LMs on your laptop"
73 |           First, install [Ollama](https://github.com/ollama/ollama) and launch its server with your LM.
74 | 
75 |           ```bash
76 |           > curl -fsSL https://ollama.ai/install.sh | sh
77 |           > ollama run llama3.2:1b
78 |           ```
79 | 
80 |           Then, connect to it from your DSPy code.
81 | 
82 |         ```python linenums="1"
83 |         import dspy
84 |         lm = dspy.LM('ollama_chat/llama3.2', api_base='http://localhost:11434', api_key='')
85 |         dspy.configure(lm=lm)
86 |         ```
87 | 
88 |     === "Other providers"
89 |         In DSPy, you can use any of the dozens of [LLM providers supported by LiteLLM](https://docs.litellm.ai/docs/providers). Simply follow their instructions for which `{PROVIDER}_API_KEY` to set and how to write pass the `{provider_name}/{model_name}` to the constructor. 
90 | 
91 |         Some examples:
92 | 
93 |         - `anyscale/mistralai/Mistral-7B-Instruct-v0.1`, with `ANYSCALE_API_KEY`
94 |         - `together_ai/togethercomputer/llama-2-70b-chat`, with `TOGETHERAI_API_KEY`
95 |         - `sagemaker/<your-endpoint-name>`, with `AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY`, and `AWS_REGION_NAME`
96 |         - `azure/<your_deployment_name>`, with `AZURE_API_KEY`, `AZURE_API_BASE`, `AZURE_API_VERSION`, and the optional `AZURE_AD_TOKEN` and `AZURE_API_TYPE` as environment variables. If you are initiating external models without setting environment variables, use the following:
97 |         `lm = dspy.LM('azure/<your_deployment_name>', api_key = 'AZURE_API_KEY' , api_base = 'AZURE_API_BASE', api_version = 'AZURE_API_VERSION')`
98 | 
99 | 
100 |         
101 |         If your provider offers an OpenAI-compatible endpoint, just add an `openai/` prefix to your full model name.
102 | 
103 |         ```python linenums="1"
104 |         import dspy
105 |         lm = dspy.LM('openai/your-model-name', api_key='PROVIDER_API_KEY', api_base='YOUR_PROVIDER_URL')
106 |         dspy.configure(lm=lm)
107 |         ```
108 | If you run into errors, please refer to the [LiteLLM Docs](https://docs.litellm.ai/docs/providers) to verify if you are using the same variable names/following the right procedure.
109 | 
110 | ## Calling the LM directly.
111 | 
112 | It's easy to call the `lm` you configured above directly. This gives you a unified API and lets you benefit from utilities like automatic caching.
113 | 
114 | ```python linenums="1"       
115 | lm("Say this is a test!", temperature=0.7)  # => ['This is a test!']
116 | lm(messages=[{"role": "user", "content": "Say this is a test!"}])  # => ['This is a test!']
117 | ``` 
118 | 
119 | ## Using the LM with DSPy modules.
120 | 
121 | Idiomatic DSPy involves using _modules_, which we discuss in the next guide.
122 | 
123 | ```python linenums="1" 
124 | # Define a module (ChainOfThought) and assign it a signature (return an answer, given a question).
125 | qa = dspy.ChainOfThought('question -> answer')
126 | 
127 | # Run with the default LM configured with `dspy.configure` above.
128 | response = qa(question="How many floors are in the castle David Gregory inherited?")
129 | print(response.answer)
130 | ```
131 | **Possible Output:**
132 | ```text
133 | The castle David Gregory inherited has 7 floors.
134 | ```
135 | 
136 | ## Using multiple LMs.
137 | 
138 | You can change the default LM globally with `dspy.configure` or change it inside a block of code with `dspy.context`.
139 | 
140 | !!! tip
141 |     Using `dspy.configure` and `dspy.context` is thread-safe!
142 | 
143 | 
144 | ```python linenums="1" 
145 | dspy.configure(lm=dspy.LM('openai/gpt-4o-mini'))
146 | response = qa(question="How many floors are in the castle David Gregory inherited?")
147 | print('GPT-4o-mini:', response.answer)
148 | 
149 | with dspy.context(lm=dspy.LM('openai/gpt-3.5-turbo')):
150 |     response = qa(question="How many floors are in the castle David Gregory inherited?")
151 |     print('GPT-3.5-turbo:', response.answer)
152 | ```
153 | **Possible Output:**
154 | ```text
155 | GPT-4o-mini: The number of floors in the castle David Gregory inherited cannot be determined with the information provided.
156 | GPT-3.5-turbo: The castle David Gregory inherited has 7 floors.
157 | ```
158 | 
159 | ## Configuring LM generation.
160 | 
161 | For any LM, you can configure any of the following attributes at initialization or in each subsequent call.
162 | 
163 | ```python linenums="1" 
164 | gpt_4o_mini = dspy.LM('openai/gpt-4o-mini', temperature=0.9, max_tokens=3000, stop=None, cache=False)
165 | ```
166 | 
167 | By default LMs in DSPy are cached. If you repeat the same call, you will get the same outputs. But you can turn off caching by setting `cache=False`.
168 | 
169 | If you want to keep caching enabled but force a new request (for example, to obtain diverse outputs),
170 | pass a unique `rollout_id` and set a non-zero `temperature` in your call. DSPy hashes both the inputs
171 | and the `rollout_id` when looking up a cache entry, so different values force a new LM request while
172 | still caching future calls with the same inputs and `rollout_id`. The ID is also recorded in
173 | `lm.history`, which makes it easy to track or compare different rollouts during experiments. Changing
174 | only the `rollout_id` while keeping `temperature=0` will not affect the LM's output.
175 | 
176 | ```python linenums="1"
177 | lm("Say this is a test!", rollout_id=1, temperature=1.0)
178 | ```
179 | 
180 | You can pass these LM kwargs directly to DSPy modules as well. Supplying them at
181 | initialization sets the defaults for every call:
182 | 
183 | ```python linenums="1"
184 | predict = dspy.Predict("question -> answer", rollout_id=1, temperature=1.0)
185 | ```
186 | 
187 | To override them for a single invocation, provide a ``config`` dictionary when
188 | calling the module:
189 | 
190 | ```python linenums="1"
191 | predict = dspy.Predict("question -> answer")
192 | predict(question="What is 1 + 52?", config={"rollout_id": 5, "temperature": 1.0})
193 | ```
194 | 
195 | In both cases, ``rollout_id`` is forwarded to the underlying LM, affects
196 | its caching behavior, and is stored alongside each response so you can
197 | replay or analyze specific rollouts later.
198 | 
199 | 
200 | ## Inspecting output and usage metadata.
201 | 
202 | Every LM object maintains the history of its interactions, including inputs, outputs, token usage (and $$$ cost), and metadata.
203 | 
204 | ```python linenums="1" 
205 | len(lm.history)  # e.g., 3 calls to the LM
206 | 
207 | lm.history[-1].keys()  # access the last call to the LM, with all metadata
208 | ```
209 | 
210 | **Output:**
211 | ```text
212 | dict_keys(['prompt', 'messages', 'kwargs', 'response', 'outputs', 'usage', 'cost', 'timestamp', 'uuid', 'model', 'response_model', 'model_type])
213 | ```
214 | 
215 | ## Using the Responses API
216 | 
217 | By default, DSPy calls language models (LMs) using LiteLLM's [Chat Completions API](https://docs.litellm.ai/docs/completion), which is suitable for most standard models and tasks. However, some advanced models, such as OpenAI's reasoning models (e.g., `gpt-5` or other future models), may offer improved quality or additional features when accessed via the [Responses API](https://docs.litellm.ai/docs/response_api), which is supported in DSPy.
218 | 
219 | **When should you use the Responses API?**
220 | 
221 | - If you are working with models that support or require the `responses` endpoint (such as OpenAI's reasoning models).
222 | - When you want to leverage enhanced reasoning, multi-turn, or richer output capabilities provided by certain models.
223 | 
224 | **How to enable the Responses API in DSPy:**
225 | 
226 | To enable the Responses API, just set `model_type="responses"` when creating the `dspy.LM` instance.
227 | 
228 | ```python
229 | import dspy
230 | 
231 | # Configure DSPy to use the Responses API for your language model
232 | dspy.settings.configure(
233 |     lm=dspy.LM(
234 |         "openai/gpt-5-mini",
235 |         model_type="responses",
236 |         temperature=1.0,
237 |         max_tokens=16000,
238 |     ),
239 | )
240 | ```
241 | 
242 | Please note that not all models or providers support the Responses API, check [LiteLLM's documentation](https://docs.litellm.ai/docs/response_api) for more details.
243 | 
244 | 
245 | ## Advanced: Building custom LMs and writing your own Adapters.
246 | 
247 | Though rarely needed, you can write custom LMs by inheriting from `dspy.BaseLM`. Another advanced layer in the DSPy ecosystem is that of _adapters_, which sit between DSPy signatures and LMs. A future version of this guide will discuss these advanced features, though you likely don't need them.
248 | 
```

programming/modules.md
```
1 | ---
2 | sidebar_position: 3
3 | ---
4 | 
5 | # Modules
6 | 
7 | A **DSPy module** is a building block for programs that use LMs.
8 | 
9 | - Each built-in module abstracts a **prompting technique** (like chain of thought or ReAct). Crucially, they are generalized to handle any signature.
10 | 
11 | - A DSPy module has **learnable parameters** (i.e., the little pieces comprising the prompt and the LM weights) and can be invoked (called) to process inputs and return outputs.
12 | 
13 | - Multiple modules can be composed into bigger modules (programs). DSPy modules are inspired directly by NN modules in PyTorch, but applied to LM programs.
14 | 
15 | 
16 | ## How do I use a built-in module, like `dspy.Predict` or `dspy.ChainOfThought`?
17 | 
18 | Let's start with the most fundamental module, `dspy.Predict`. Internally, all other DSPy modules are built using `dspy.Predict`. We'll assume you are already at least a little familiar with [DSPy signatures](signatures.md), which are declarative specs for defining the behavior of any module we use in DSPy.
19 | 
20 | To use a module, we first **declare** it by giving it a signature. Then we **call** the module with the input arguments, and extract the output fields!
21 | 
22 | ```python
23 | sentence = "it's a charming and often affecting journey."  # example from the SST-2 dataset.
24 | 
25 | # 1) Declare with a signature.
26 | classify = dspy.Predict('sentence -> sentiment: bool')
27 | 
28 | # 2) Call with input argument(s). 
29 | response = classify(sentence=sentence)
30 | 
31 | # 3) Access the output.
32 | print(response.sentiment)
33 | ```
34 | **Output:**
35 | ```text
36 | True
37 | ```
38 | 
39 | When we declare a module, we can pass configuration keys to it.
40 | 
41 | Below, we'll pass `n=5` to request five completions. We can also pass `temperature` or `max_len`, etc.
42 | 
43 | Let's use `dspy.ChainOfThought`. In many cases, simply swapping `dspy.ChainOfThought` in place of `dspy.Predict` improves quality.
44 | 
45 | ```python
46 | question = "What's something great about the ColBERT retrieval model?"
47 | 
48 | # 1) Declare with a signature, and pass some config.
49 | classify = dspy.ChainOfThought('question -> answer', n=5)
50 | 
51 | # 2) Call with input argument.
52 | response = classify(question=question)
53 | 
54 | # 3) Access the outputs.
55 | response.completions.answer
56 | ```
57 | **Possible Output:**
58 | ```text
59 | ['One great thing about the ColBERT retrieval model is its superior efficiency and effectiveness compared to other models.',
60 |  'Its ability to efficiently retrieve relevant information from large document collections.',
61 |  'One great thing about the ColBERT retrieval model is its superior performance compared to other models and its efficient use of pre-trained language models.',
62 |  'One great thing about the ColBERT retrieval model is its superior efficiency and accuracy compared to other models.',
63 |  'One great thing about the ColBERT retrieval model is its ability to incorporate user feedback and support complex queries.']
64 | ```
65 | 
66 | Let's discuss the output object here. The `dspy.ChainOfThought` module will generally inject a `reasoning` before the output field(s) of your signature.
67 | 
68 | Let's inspect the (first) reasoning and answer!
69 | 
70 | ```python
71 | print(f"Reasoning: {response.reasoning}")
72 | print(f"Answer: {response.answer}")
73 | ```
74 | **Possible Output:**
75 | ```text
76 | Reasoning: We can consider the fact that ColBERT has shown to outperform other state-of-the-art retrieval models in terms of efficiency and effectiveness. It uses contextualized embeddings and performs document retrieval in a way that is both accurate and scalable.
77 | Answer: One great thing about the ColBERT retrieval model is its superior efficiency and effectiveness compared to other models.
78 | ```
79 | 
80 | This is accessible whether we request one or many completions.
81 | 
82 | We can also access the different completions as a list of `Prediction`s or as several lists, one for each field.
83 | 
84 | ```python
85 | response.completions[3].reasoning == response.completions.reasoning[3]
86 | ```
87 | **Output:**
88 | ```text
89 | True
90 | ```
91 | 
92 | 
93 | ## What other DSPy modules are there? How can I use them?
94 | 
95 | The others are very similar. They mainly change the internal behavior with which your signature is implemented!
96 | 
97 | 1. **`dspy.Predict`**: Basic predictor. Does not modify the signature. Handles the key forms of learning (i.e., storing the instructions and demonstrations and updates to the LM).
98 | 
99 | 2. **`dspy.ChainOfThought`**: Teaches the LM to think step-by-step before committing to the signature's response.
100 | 
101 | 3. **`dspy.ProgramOfThought`**: Teaches the LM to output code, whose execution results will dictate the response.
102 | 
103 | 4. **`dspy.ReAct`**: An agent that can use tools to implement the given signature.
104 | 
105 | 5. **`dspy.MultiChainComparison`**: Can compare multiple outputs from `ChainOfThought` to produce a final prediction.
106 | 
107 | 
108 | We also have some function-style modules:
109 | 
110 | 6. **`dspy.majority`**: Can do basic voting to return the most popular response from a set of predictions.
111 | 
112 | 
113 | !!! info "A few examples of DSPy modules on simple tasks."
114 |     Try the examples below after configuring your `lm`. Adjust the fields to explore what tasks your LM can do well out of the box.
115 | 
116 |     === "Math"
117 | 
118 |         ```python linenums="1"
119 |         math = dspy.ChainOfThought("question -> answer: float")
120 |         math(question="Two dice are tossed. What is the probability that the sum equals two?")
121 |         ```
122 |         
123 |         **Possible Output:**
124 |         ```text
125 |         Prediction(
126 |             reasoning='When two dice are tossed, each die has 6 faces, resulting in a total of 6 x 6 = 36 possible outcomes. The sum of the numbers on the two dice equals two only when both dice show a 1. This is just one specific outcome: (1, 1). Therefore, there is only 1 favorable outcome. The probability of the sum being two is the number of favorable outcomes divided by the total number of possible outcomes, which is 1/36.',
127 |             answer=0.0277776
128 |         )
129 |         ```
130 | 
131 |     === "Retrieval-Augmented Generation"
132 | 
133 |         ```python linenums="1"       
134 |         def search(query: str) -> list[str]:
135 |             """Retrieves abstracts from Wikipedia."""
136 |             results = dspy.ColBERTv2(url='http://20.102.90.50:2017/wiki17_abstracts')(query, k=3)
137 |             return [x['text'] for x in results]
138 |         
139 |         rag = dspy.ChainOfThought('context, question -> response')
140 | 
141 |         question = "What's the name of the castle that David Gregory inherited?"
142 |         rag(context=search(question), question=question)
143 |         ```
144 |         
145 |         **Possible Output:**
146 |         ```text
147 |         Prediction(
148 |             reasoning='The context provides information about David Gregory, a Scottish physician and inventor. It specifically mentions that he inherited Kinnairdy Castle in 1664. This detail directly answers the question about the name of the castle that David Gregory inherited.',
149 |             response='Kinnairdy Castle'
150 |         )
151 |         ```
152 | 
153 |     === "Classification"
154 | 
155 |         ```python linenums="1"
156 |         from typing import Literal
157 | 
158 |         class Classify(dspy.Signature):
159 |             """Classify sentiment of a given sentence."""
160 |             
161 |             sentence: str = dspy.InputField()
162 |             sentiment: Literal['positive', 'negative', 'neutral'] = dspy.OutputField()
163 |             confidence: float = dspy.OutputField()
164 | 
165 |         classify = dspy.Predict(Classify)
166 |         classify(sentence="This book was super fun to read, though not the last chapter.")
167 |         ```
168 |         
169 |         **Possible Output:**
170 | 
171 |         ```text
172 |         Prediction(
173 |             sentiment='positive',
174 |             confidence=0.75
175 |         )
176 |         ```
177 | 
178 |     === "Information Extraction"
179 | 
180 |         ```python linenums="1"        
181 |         text = "Apple Inc. announced its latest iPhone 14 today. The CEO, Tim Cook, highlighted its new features in a press release."
182 | 
183 |         module = dspy.Predict("text -> title, headings: list[str], entities_and_metadata: list[dict[str, str]]")
184 |         response = module(text=text)
185 | 
186 |         print(response.title)
187 |         print(response.headings)
188 |         print(response.entities_and_metadata)
189 |         ```
190 |         
191 |         **Possible Output:**
192 |         ```text
193 |         Apple Unveils iPhone 14
194 |         ['Introduction', 'Key Features', "CEO's Statement"]
195 |         [{'entity': 'Apple Inc.', 'type': 'Organization'}, {'entity': 'iPhone 14', 'type': 'Product'}, {'entity': 'Tim Cook', 'type': 'Person'}]
196 |         ```
197 | 
198 |     === "Agents"
199 | 
200 |         ```python linenums="1"       
201 |         def evaluate_math(expression: str) -> float:
202 |             return dspy.PythonInterpreter({}).execute(expression)
203 | 
204 |         def search_wikipedia(query: str) -> str:
205 |             results = dspy.ColBERTv2(url='http://20.102.90.50:2017/wiki17_abstracts')(query, k=3)
206 |             return [x['text'] for x in results]
207 | 
208 |         react = dspy.ReAct("question -> answer: float", tools=[evaluate_math, search_wikipedia])
209 | 
210 |         pred = react(question="What is 9362158 divided by the year of birth of David Gregory of Kinnairdy castle?")
211 |         print(pred.answer)
212 |         ```
213 |         
214 |         **Possible Output:**
215 | 
216 |         ```text
217 |         5761.328
218 |         ```
219 | 
220 | 
221 | ## How do I compose multiple modules into a bigger program?
222 | 
223 | DSPy is just Python code that uses modules in any control flow you like, with a little magic internally at `compile` time to trace your LM calls. What this means is that, you can just call the modules freely.
224 | 
225 | See tutorials like [multi-hop search](https://dspy.ai/tutorials/multihop_search/), whose module is reproduced below as an example.
226 | 
227 | ```python linenums="1"        
228 | class Hop(dspy.Module):
229 |     def __init__(self, num_docs=10, num_hops=4):
230 |         self.num_docs, self.num_hops = num_docs, num_hops
231 |         self.generate_query = dspy.ChainOfThought('claim, notes -> query')
232 |         self.append_notes = dspy.ChainOfThought('claim, notes, context -> new_notes: list[str], titles: list[str]')
233 | 
234 |     def forward(self, claim: str) -> list[str]:
235 |         notes = []
236 |         titles = []
237 | 
238 |         for _ in range(self.num_hops):
239 |             query = self.generate_query(claim=claim, notes=notes).query
240 |             context = search(query, k=self.num_docs)
241 |             prediction = self.append_notes(claim=claim, notes=notes, context=context)
242 |             notes.extend(prediction.new_notes)
243 |             titles.extend(prediction.titles)
244 |         
245 |         return dspy.Prediction(notes=notes, titles=list(set(titles)))
246 | ```
247 | 
248 | Then you can create a instance of the custom module class `Hop`, then invoke it by the `__call__` method:
249 | 
250 | ```
251 | hop = Hop()
252 | print(hop(claim="Stephen Curry is the best 3 pointer shooter ever in the human history"))
253 | ```
254 | 
255 | ## How do I track LM usage?
256 | 
257 | !!! note "Version Requirement"
258 |     LM usage tracking is available in DSPy version 2.6.16 and later.
259 | 
260 | DSPy provides built-in tracking of language model usage across all module calls. To enable tracking:
261 | 
262 | ```python
263 | dspy.settings.configure(track_usage=True)
264 | ```
265 | 
266 | Once enabled, you can access usage statistics from any `dspy.Prediction` object:
267 | 
268 | ```python
269 | usage = prediction_instance.get_lm_usage()
270 | ```
271 | 
272 | The usage data is returned as a dictionary that maps each language model name to its usage statistics. Here's a complete example:
273 | 
274 | ```python
275 | import dspy
276 | 
277 | # Configure DSPy with tracking enabled
278 | dspy.settings.configure(
279 |     lm=dspy.LM("openai/gpt-4o-mini", cache=False),
280 |     track_usage=True
281 | )
282 | 
283 | # Define a simple program that makes multiple LM calls
284 | class MyProgram(dspy.Module):
285 |     def __init__(self):
286 |         self.predict1 = dspy.ChainOfThought("question -> answer")
287 |         self.predict2 = dspy.ChainOfThought("question, answer -> score")
288 | 
289 |     def __call__(self, question: str) -> str:
290 |         answer = self.predict1(question=question)
291 |         score = self.predict2(question=question, answer=answer)
292 |         return score
293 | 
294 | # Run the program and check usage
295 | program = MyProgram()
296 | output = program(question="What is the capital of France?")
297 | print(output.get_lm_usage())
298 | ```
299 | 
300 | This will output usage statistics like:
301 | 
302 | ```python
303 | {
304 |     'openai/gpt-4o-mini': {
305 |         'completion_tokens': 61,
306 |         'prompt_tokens': 260,
307 |         'total_tokens': 321,
308 |         'completion_tokens_details': {
309 |             'accepted_prediction_tokens': 0,
310 |             'audio_tokens': 0,
311 |             'reasoning_tokens': 0,
312 |             'rejected_prediction_tokens': 0,
313 |             'text_tokens': None
314 |         },
315 |         'prompt_tokens_details': {
316 |             'audio_tokens': 0,
317 |             'cached_tokens': 0,
318 |             'text_tokens': None,
319 |             'image_tokens': None
320 |         }
321 |     }
322 | }
323 | ```
324 | 
325 | When using DSPy's caching features (either in-memory or on-disk via litellm), cached responses won't count toward usage statistics. For example:
326 | 
327 | ```python
328 | # Enable caching
329 | dspy.settings.configure(
330 |     lm=dspy.LM("openai/gpt-4o-mini", cache=True),
331 |     track_usage=True
332 | )
333 | 
334 | program = MyProgram()
335 | 
336 | # First call - will show usage statistics
337 | output = program(question="What is the capital of Zambia?")
338 | print(output.get_lm_usage())  # Shows token usage
339 | 
340 | # Second call - same question, will use cache
341 | output = program(question="What is the capital of Zambia?")
342 | print(output.get_lm_usage())  # Shows empty dict: {}
343 | ```
```

programming/overview.md
```
1 | ---
2 | sidebar_position: 1
3 | ---
4 | 
5 | # Programming in DSPy
6 | 
7 | DSPy is a bet on _writing code instead of strings_. In other words, building the right control flow is crucial. Start by **defining your task**. What are the inputs to your system and what should your system produce as output? Is it a chatbot over your data or perhaps a code assistant? Or maybe a system for translation, for highlighting snippets from search results, or for generating reports with citations?
8 | 
9 | Next, **define your initial pipeline**. Can your DSPy program just be a single module or do you need to break it down into a few steps? Do you need retrieval or other tools, like a calculator or a calendar API? Is there a typical workflow for solving your problem in multiple well-scoped steps, or do you want more open-ended tool use with agents for your task? Think about these but start simple, perhaps with just a single `dspy.ChainOfThought` module, then add complexity incrementally based on observations.
10 | 
11 | As you do this, **craft and try a handful of examples** of the inputs to your program. Consider using a powerful LM at this point, or a couple of different LMs, just to understand what's possible. Record interesting (both easy and hard) examples you try. This will be useful when you are doing evaluation and optimization later.
12 | 
13 | 
14 | ??? "Beyond encouraging good design patterns, how does DSPy help here?"
15 | 
16 |     Conventional prompts couple your fundamental system architecture with incidental choices not portable to new LMs, objectives, or pipelines. A conventional prompt asks the LM to take some inputs and produce some outputs of certain types (a _signature_), formats the inputs in certain ways and requests outputs in a form it can parse accurately (an _adapter_), asks the LM to apply certain strategies like "thinking step by step" or using tools (a _module_'s logic), and relies on substantial trial-and-error to discover the right way to ask each LM to do this (a form of manual _optimization_).
17 |     
18 |     DSPy separates these concerns and automates the lower-level ones until you need to consider them. This allow you to write much shorter code, with much higher portability. For example, if you write a program using DSPy modules, you can swap the LM or its adapter without changing the rest of your logic. Or you can exchange one _module_, like `dspy.ChainOfThought`, with another, like `dspy.ProgramOfThought`, without modifying your signatures. When you're ready to use optimizers, the same program can have its prompts optimized or its LM weights fine-tuned.
```

programming/signatures.md
```
1 | ---
2 | sidebar_position: 2
3 | ---
4 | 
5 | # Signatures
6 | 
7 | When we assign tasks to LMs in DSPy, we specify the behavior we need as a Signature.
8 | 
9 | **A signature is a declarative specification of input/output behavior of a DSPy module.** Signatures allow you to tell the LM _what_ it needs to do, rather than specify _how_ we should ask the LM to do it.
10 | 
11 | You're probably familiar with function signatures, which specify the input and output arguments and their types. DSPy signatures are similar, but with a couple of differences. While typical function signatures just _describe_ things, DSPy Signatures _declare and initialize the behavior_ of modules. Moreover, the field names matter in DSPy Signatures. You express semantic roles in plain English: a `question` is different from an `answer`, a `sql_query` is different from `python_code`.
12 | 
13 | ## Why should I use a DSPy Signature?
14 | 
15 | For modular and clean code, in which LM calls can be optimized into high-quality prompts (or automatic finetunes). Most people coerce LMs to do tasks by hacking long, brittle prompts. Or by collecting/generating data for fine-tuning. Writing signatures is far more modular, adaptive, and reproducible than hacking at prompts or finetunes. The DSPy compiler will figure out how to build a highly-optimized prompt for your LM (or finetune your small LM) for your signature, on your data, and within your pipeline. In many cases, we found that compiling leads to better prompts than humans write. Not because DSPy optimizers are more creative than humans, but simply because they can try more things and tune the metrics directly.
16 | 
17 | ## **Inline** DSPy Signatures
18 | 
19 | Signatures can be defined as a short string, with argument names and optional types that define semantic roles for inputs/outputs.
20 | 
21 | 1. Question Answering: `"question -> answer"`, which is equivalent to `"question: str -> answer: str"` as the default type is always `str`
22 | 
23 | 2. Sentiment Classification: `"sentence -> sentiment: bool"`, e.g. `True` if positive
24 | 
25 | 3. Summarization: `"document -> summary"`
26 | 
27 | Your signatures can also have multiple input/output fields with types:
28 | 
29 | 4. Retrieval-Augmented Question Answering: `"context: list[str], question: str -> answer: str"`
30 | 
31 | 5. Multiple-Choice Question Answering with Reasoning: `"question, choices: list[str] -> reasoning: str, selection: int"`
32 | 
33 | **Tip:** For fields, any valid variable names work! Field names should be semantically meaningful, but start simple and don't prematurely optimize keywords! Leave that kind of hacking to the DSPy compiler. For example, for summarization, it's probably fine to say `"document -> summary"`, `"text -> gist"`, or `"long_context -> tldr"`.
34 | 
35 | You can also add instructions to your inline signature, which can use variables at runtime. Use the `instructions` keyword argument to add instructions to your signature.
36 | 
37 | ```python
38 | toxicity = dspy.Predict(
39 |     dspy.Signature(
40 |         "comment -> toxic: bool",
41 |         instructions="Mark as 'toxic' if the comment includes insults, harassment, or sarcastic derogatory remarks.",
42 |     )
43 | )
44 | comment = "you are beautiful."
45 | toxicity(comment=comment).toxic
46 | ```
47 | 
48 | **Output:**
49 | ```text
50 | False
51 | ```
52 | 
53 | 
54 | ### Example A: Sentiment Classification
55 | 
56 | ```python
57 | sentence = "it's a charming and often affecting journey."  # example from the SST-2 dataset.
58 | 
59 | classify = dspy.Predict('sentence -> sentiment: bool')  # we'll see an example with Literal[] later
60 | classify(sentence=sentence).sentiment
61 | ```
62 | **Output:**
63 | ```text
64 | True
65 | ```
66 | 
67 | ### Example B: Summarization
68 | 
69 | ```python
70 | # Example from the XSum dataset.
71 | document = """The 21-year-old made seven appearances for the Hammers and netted his only goal for them in a Europa League qualification round match against Andorran side FC Lustrains last season. Lee had two loan spells in League One last term, with Blackpool and then Colchester United. He scored twice for the U's but was unable to save them from relegation. The length of Lee's contract with the promoted Tykes has not been revealed. Find all the latest football transfers on our dedicated page."""
72 | 
73 | summarize = dspy.ChainOfThought('document -> summary')
74 | response = summarize(document=document)
75 | 
76 | print(response.summary)
77 | ```
78 | **Possible Output:**
79 | ```text
80 | The 21-year-old Lee made seven appearances and scored one goal for West Ham last season. He had loan spells in League One with Blackpool and Colchester United, scoring twice for the latter. He has now signed a contract with Barnsley, but the length of the contract has not been revealed.
81 | ```
82 | 
83 | Many DSPy modules (except `dspy.Predict`) return auxiliary information by expanding your signature under the hood.
84 | 
85 | For example, `dspy.ChainOfThought` also adds a `reasoning` field that includes the LM's reasoning before it generates the output `summary`.
86 | 
87 | ```python
88 | print("Reasoning:", response.reasoning)
89 | ```
90 | **Possible Output:**
91 | ```text
92 | Reasoning: We need to highlight Lee's performance for West Ham, his loan spells in League One, and his new contract with Barnsley. We also need to mention that his contract length has not been disclosed.
93 | ```
94 | 
95 | ## **Class-based** DSPy Signatures
96 | 
97 | For some advanced tasks, you need more verbose signatures. This is typically to:
98 | 
99 | 1. Clarify something about the nature of the task (expressed below as a `docstring`).
100 | 
101 | 2. Supply hints on the nature of an input field, expressed as a `desc` keyword argument for `dspy.InputField`.
102 | 
103 | 3. Supply constraints on an output field, expressed as a `desc` keyword argument for `dspy.OutputField`.
104 | 
105 | ### Example C: Classification
106 | 
107 | ```python
108 | from typing import Literal
109 | 
110 | class Emotion(dspy.Signature):
111 |     """Classify emotion."""
112 |     
113 |     sentence: str = dspy.InputField()
114 |     sentiment: Literal['sadness', 'joy', 'love', 'anger', 'fear', 'surprise'] = dspy.OutputField()
115 | 
116 | sentence = "i started feeling a little vulnerable when the giant spotlight started blinding me"  # from dair-ai/emotion
117 | 
118 | classify = dspy.Predict(Emotion)
119 | classify(sentence=sentence)
120 | ```
121 | **Possible Output:**
122 | ```text
123 | Prediction(
124 |     sentiment='fear'
125 | )
126 | ```
127 | 
128 | **Tip:** There's nothing wrong with specifying your requests to the LM more clearly. Class-based Signatures help you with that. However, don't prematurely tune the keywords of your signature by hand. The DSPy optimizers will likely do a better job (and will transfer better across LMs).
129 | 
130 | ### Example D: A metric that evaluates faithfulness to citations
131 | 
132 | ```python
133 | class CheckCitationFaithfulness(dspy.Signature):
134 |     """Verify that the text is based on the provided context."""
135 | 
136 |     context: str = dspy.InputField(desc="facts here are assumed to be true")
137 |     text: str = dspy.InputField()
138 |     faithfulness: bool = dspy.OutputField()
139 |     evidence: dict[str, list[str]] = dspy.OutputField(desc="Supporting evidence for claims")
140 | 
141 | context = "The 21-year-old made seven appearances for the Hammers and netted his only goal for them in a Europa League qualification round match against Andorran side FC Lustrains last season. Lee had two loan spells in League One last term, with Blackpool and then Colchester United. He scored twice for the U's but was unable to save them from relegation. The length of Lee's contract with the promoted Tykes has not been revealed. Find all the latest football transfers on our dedicated page."
142 | 
143 | text = "Lee scored 3 goals for Colchester United."
144 | 
145 | faithfulness = dspy.ChainOfThought(CheckCitationFaithfulness)
146 | faithfulness(context=context, text=text)
147 | ```
148 | **Possible Output:**
149 | ```text
150 | Prediction(
151 |     reasoning="Let's check the claims against the context. The text states Lee scored 3 goals for Colchester United, but the context clearly states 'He scored twice for the U's'. This is a direct contradiction.",
152 |     faithfulness=False,
153 |     evidence={'goal_count': ["scored twice for the U's"]}
154 | )
155 | ```
156 | 
157 | ### Example E: Multi-modal image classification
158 | 
159 | ```python
160 | class DogPictureSignature(dspy.Signature):
161 |     """Output the dog breed of the dog in the image."""
162 |     image_1: dspy.Image = dspy.InputField(desc="An image of a dog")
163 |     answer: str = dspy.OutputField(desc="The dog breed of the dog in the image")
164 | 
165 | image_url = "https://picsum.photos/id/237/200/300"
166 | classify = dspy.Predict(DogPictureSignature)
167 | classify(image_1=dspy.Image.from_url(image_url))
168 | ```
169 | 
170 | **Possible Output:**
171 | 
172 | ```text
173 | Prediction(
174 |     answer='Labrador Retriever'
175 | )
176 | ```
177 | 
178 | ## Type Resolution in Signatures
179 | 
180 | DSPy signatures support various annotation types:
181 | 
182 | 1. **Basic types** like `str`, `int`, `bool`
183 | 2. **Typing module types** like `list[str]`, `dict[str, int]`, `Optional[float]`. `Union[str, int]`
184 | 3. **Custom types** defined in your code
185 | 4. **Dot notation** for nested types with proper configuration
186 | 5. **Special data types** like `dspy.Image, dspy.History`
187 | 
188 | ### Working with Custom Types
189 | 
190 | ```python
191 | # Simple custom type
192 | class QueryResult(pydantic.BaseModel):
193 |     text: str
194 |     score: float
195 | 
196 | signature = dspy.Signature("query: str -> result: QueryResult")
197 | 
198 | class MyContainer:
199 |     class Query(pydantic.BaseModel):
200 |         text: str
201 |     class Score(pydantic.BaseModel):
202 |         score: float
203 | 
204 | signature = dspy.Signature("query: MyContainer.Query -> score: MyContainer.Score")
205 | ```
206 | 
207 | ## Using signatures to build modules & compiling them
208 | 
209 | While signatures are convenient for prototyping with structured inputs/outputs, that's not the only reason to use them!
210 | 
211 | You should compose multiple signatures into bigger [DSPy modules](modules.md) and [compile these modules into optimized prompts](../optimization/optimizers.md) and finetunes.
```

programming/tools.md
```
1 | ---
2 | sidebar_position: 2
3 | ---
4 | 
5 | # Tools
6 | 
7 | DSPy provides powerful support for **tool-using agents** that can interact with external functions, APIs, and services. Tools enable language models to go beyond text generation by performing actions, retrieving information, and processing data dynamically.
8 | 
9 | There are two main approaches to using tools in DSPy:
10 | 
11 | 1. **`dspy.ReAct`** - A fully managed tool agent that handles reasoning and tool calls automatically
12 | 2. **Manual tool handling** - Direct control over tool calls using `dspy.Tool`, `dspy.ToolCalls`, and custom signatures
13 | 
14 | ## Approach 1: Using `dspy.ReAct` (Fully Managed)
15 | 
16 | The `dspy.ReAct` module implements the Reasoning and Acting (ReAct) pattern, where the language model iteratively reasons about the current situation and decides which tools to call.
17 | 
18 | ### Basic Example
19 | 
20 | ```python
21 | import dspy
22 | 
23 | # Define your tools as functions
24 | def get_weather(city: str) -> str:
25 |     """Get the current weather for a city."""
26 |     # In a real implementation, this would call a weather API
27 |     return f"The weather in {city} is sunny and 75°F"
28 | 
29 | def search_web(query: str) -> str:
30 |     """Search the web for information."""
31 |     # In a real implementation, this would call a search API
32 |     return f"Search results for '{query}': [relevant information...]"
33 | 
34 | # Create a ReAct agent
35 | react_agent = dspy.ReAct(
36 |     signature="question -> answer",
37 |     tools=[get_weather, search_web],
38 |     max_iters=5
39 | )
40 | 
41 | # Use the agent
42 | result = react_agent(question="What's the weather like in Tokyo?")
43 | print(result.answer)
44 | print("Tool calls made:", result.trajectory)
45 | ```
46 | 
47 | ### ReAct Features
48 | 
49 | - **Automatic reasoning**: The model thinks through the problem step by step
50 | - **Tool selection**: Automatically chooses which tool to use based on the situation
51 | - **Iterative execution**: Can make multiple tool calls to gather information
52 | - **Error handling**: Built-in error recovery for failed tool calls
53 | - **Trajectory tracking**: Complete history of reasoning and tool calls
54 | 
55 | ### ReAct Parameters
56 | 
57 | ```python
58 | react_agent = dspy.ReAct(
59 |     signature="question -> answer",  # Input/output specification
60 |     tools=[tool1, tool2, tool3],     # List of available tools
61 |     max_iters=10                     # Maximum number of tool call iterations
62 | )
63 | ```
64 | 
65 | ## Approach 2: Manual Tool Handling
66 | 
67 | For more control over the tool calling process, you can manually handle tools using DSPy's tool types.
68 | 
69 | ### Basic Setup
70 | 
71 | ```python
72 | import dspy
73 | 
74 | class ToolSignature(dspy.Signature):
75 |     """Signature for manual tool handling."""
76 |     question: str = dspy.InputField()
77 |     tools: list[dspy.Tool] = dspy.InputField()
78 |     outputs: dspy.ToolCalls = dspy.OutputField()
79 | 
80 | def weather(city: str) -> str:
81 |     """Get weather information for a city."""
82 |     return f"The weather in {city} is sunny"
83 | 
84 | def calculator(expression: str) -> str:
85 |     """Evaluate a mathematical expression."""
86 |     try:
87 |         result = eval(expression)  # Note: Use safely in production
88 |         return f"The result is {result}"
89 |     except:
90 |         return "Invalid expression"
91 | 
92 | # Create tool instances
93 | tools = {
94 |     "weather": dspy.Tool(weather),
95 |     "calculator": dspy.Tool(calculator)
96 | }
97 | 
98 | # Create predictor
99 | predictor = dspy.Predict(ToolSignature)
100 | 
101 | # Make a prediction
102 | response = predictor(
103 |     question="What's the weather in New York?",
104 |     tools=list(tools.values())
105 | )
106 | 
107 | # Execute the tool calls
108 | for call in response.outputs.tool_calls:
109 |     # Execute the tool call
110 |     result = call.execute()
111 |     print(f"Tool: {call.name}")
112 |     print(f"Args: {call.args}")
113 |     print(f"Result: {result}")
114 | ```
115 | 
116 | ### Understanding `dspy.Tool`
117 | 
118 | The `dspy.Tool` class wraps regular Python functions to make them compatible with DSPy's tool system:
119 | 
120 | ```python
121 | def my_function(param1: str, param2: int = 5) -> str:
122 |     """A sample function with parameters."""
123 |     return f"Processed {param1} with value {param2}"
124 | 
125 | # Create a tool
126 | tool = dspy.Tool(my_function)
127 | 
128 | # Tool properties
129 | print(tool.name)        # "my_function"
130 | print(tool.desc)        # The function's docstring
131 | print(tool.args)        # Parameter schema
132 | print(str(tool))        # Full tool description
133 | ```
134 | 
135 | ### Understanding `dspy.ToolCalls`
136 | 
137 | The `dspy.ToolCalls` type represents the output from a model that can make tool calls. Each individual tool call can be executed using the `execute` method:
138 | 
139 | ```python
140 | # After getting a response with tool calls
141 | for call in response.outputs.tool_calls:
142 |     print(f"Tool name: {call.name}")
143 |     print(f"Arguments: {call.args}")
144 |     
145 |     # Execute individual tool calls with different options:
146 |     
147 |     # Option 1: Automatic discovery (finds functions in locals/globals)
148 |     result = call.execute()  # Automatically finds functions by name
149 | 
150 |     # Option 2: Pass tools as a dict (most explicit)
151 |     result = call.execute(functions={"weather": weather, "calculator": calculator})
152 |     
153 |     # Option 3: Pass Tool objects as a list
154 |     result = call.execute(functions=[dspy.Tool(weather), dspy.Tool(calculator)])
155 |     
156 |     print(f"Result: {result}")
157 | ```
158 | 
159 | ## Using Native Tool Calling
160 | 
161 | DSPy adapters support **native function calling**, which leverages the underlying language model's built-in tool calling capabilities rather
162 | than relying on text-based parsing. This approach can provide more reliable tool execution and better integration with models that support
163 | native function calling.
164 | 
165 | !!! warning "Native tool calling doesn't guarantee better quality"
166 | 
167 |     It's possible that native tool calling produces lower quality than custom tool calling.
168 | 
169 | ### Adapter Behavior
170 | 
171 | Different DSPy adapters have different defaults for native function calling:
172 | 
173 | - **`ChatAdapter`** - Uses `use_native_function_calling=False` by default (relies on text parsing)
174 | - **`JSONAdapter`** - Uses `use_native_function_calling=True` by default (uses native function calling)
175 | 
176 | You can override these defaults by explicitly setting the `use_native_function_calling` parameter when creating an adapter.
177 | 
178 | ### Configuration
179 | 
180 | ```python
181 | import dspy
182 | 
183 | # ChatAdapter with native function calling enabled
184 | chat_adapter_native = dspy.ChatAdapter(use_native_function_calling=True)
185 | 
186 | # JSONAdapter with native function calling disabled
187 | json_adapter_manual = dspy.JSONAdapter(use_native_function_calling=False)
188 | 
189 | # Configure DSPy to use the adapter
190 | dspy.configure(lm=dspy.LM(model="openai/gpt-4o"), adapter=chat_adapter_native)
191 | ```
192 | 
193 | You can enable the [MLflow tracing](https://dspy.ai/tutorials/observability/) to check how native tool
194 | calling is being used. If you use `JSONAdapter` or `ChatAdapter` with native function calling enabled on the code snippet
195 | as provided in [the section above](tools.md#basic-setup), you should see native function calling arg `tools` is set like
196 | the screenshot below:
197 | 
198 | ![native tool calling](../figures/native_tool_call.png)
199 | 
200 | 
201 | ### Model Compatibility
202 | 
203 | Native function calling automatically detects model support using `litellm.supports_function_calling()`. If the model doesn't support native function calling, DSPy will fall back to manual text-based parsing even when `use_native_function_calling=True` is set.
204 | 
205 | ## Best Practices
206 | 
207 | ### 1. Tool Function Design
208 | 
209 | - **Clear docstrings**: Tools work better with descriptive documentation
210 | - **Type hints**: Provide clear parameter and return types
211 | - **Simple parameters**: Use basic types (str, int, bool, dict, list) or Pydantic models
212 | 
213 | ```python
214 | def good_tool(city: str, units: str = "celsius") -> str:
215 |     """
216 |     Get weather information for a specific city.
217 |     
218 |     Args:
219 |         city: The name of the city to get weather for
220 |         units: Temperature units, either 'celsius' or 'fahrenheit'
221 |     
222 |     Returns:
223 |         A string describing the current weather conditions
224 |     """
225 |     # Implementation with proper error handling
226 |     if not city.strip():
227 |         return "Error: City name cannot be empty"
228 |     
229 |     # Weather logic here...
230 |     return f"Weather in {city}: 25°{units[0].upper()}, sunny"
231 | ```
232 | 
233 | ### 2. Choosing Between ReAct and Manual Handling
234 | 
235 | **Use `dspy.ReAct` when:**
236 | 
237 | - You want automatic reasoning and tool selection
238 | - The task requires multiple tool calls
239 | - You need built-in error recovery
240 | - You want to focus on tool implementation rather than orchestration
241 | 
242 | **Use manual tool handling when:**
243 | 
244 | - You need precise control over tool execution
245 | - You want custom error handling logic
246 | - You want to minimize the latency
247 | - Your tool returns nothing (void function)
248 | 
249 | 
250 | Tools in DSPy provide a powerful way to extend language model capabilities beyond text generation. Whether using the fully automated ReAct approach or manual tool handling, you can build sophisticated agents that interact with the world through code.
```

optimization/optimizers.md
```
1 | ---
2 | sidebar_position: 1
3 | ---
4 | 
5 | # DSPy Optimizers (formerly Teleprompters)
6 | 
7 | 
8 | A **DSPy optimizer** is an algorithm that can tune the parameters of a DSPy program (i.e., the prompts and/or the LM weights) to maximize the metrics you specify, like accuracy.
9 | 
10 | 
11 | A typical DSPy optimizer takes three things:
12 | 
13 | - Your **DSPy program**. This may be a single module (e.g., `dspy.Predict`) or a complex multi-module program.
14 | 
15 | - Your **metric**. This is a function that evaluates the output of your program, and assigns it a score (higher is better).
16 | 
17 | - A few **training inputs**. This may be very small (i.e., only 5 or 10 examples) and incomplete (only inputs to your program, without any labels).
18 | 
19 | If you happen to have a lot of data, DSPy can leverage that. But you can start small and get strong results.
20 | 
21 | **Note:** Formerly called teleprompters. We are making an official name update, which will be reflected throughout the library and documentation.
22 | 
23 | 
24 | ## What does a DSPy Optimizer tune? How does it tune them?
25 | 
26 | Different optimizers in DSPy will tune your program's quality by **synthesizing good few-shot examples** for every module, like `dspy.BootstrapRS`,<sup>[1](https://arxiv.org/abs/2310.03714)</sup> **proposing and intelligently exploring better natural-language instructions** for every prompt, like `dspy.MIPROv2`,<sup>[2](https://arxiv.org/abs/2406.11695)</sup> and `dspy.GEPA`,<sup>[3](https://arxiv.org/abs/2507.19457)</sup> and **building datasets for your modules and using them to finetune the LM weights** in your system, like `dspy.BootstrapFinetune`.<sup>[4](https://arxiv.org/abs/2407.10930)</sup>
27 | 
28 | ??? "What's an example of a DSPy optimizer? How do different optimizers work?"
29 | 
30 |     Take the `dspy.MIPROv2` optimizer as an example. First, MIPRO starts with the **bootstrapping stage**. It takes your program, which may be unoptimized at this point, and runs it many times across different inputs to collect traces of input/output behavior for each one of your modules. It filters these traces to keep only those that appear in trajectories scored highly by your metric. Second, MIPRO enters its **grounded proposal stage**. It previews your DSPy program's code, your data, and traces from running your program, and uses them to draft many potential instructions for every prompt in your program. Third, MIPRO launches the **discrete search stage**. It samples mini-batches from your training set, proposes a combination of instructions and traces to use for constructing every prompt in the pipeline, and evaluates the candidate program on the mini-batch. Using the resulting score, MIPRO updates a surrogate model that helps the proposals get better over time.
31 | 
32 |     One thing that makes DSPy optimizers so powerful is that they can be composed. You can run `dspy.MIPROv2` and use the produced program as an input to `dspy.MIPROv2` again or, say, to `dspy.BootstrapFinetune` to get better results. This is partly the essence of `dspy.BetterTogether`. Alternatively, you can run the optimizer and then extract the top-5 candidate programs and build a `dspy.Ensemble` of them. This allows you to scale _inference-time compute_ (e.g., ensembles) as well as DSPy's unique _pre-inference time compute_ (i.e., optimization budget) in highly systematic ways.
33 | 
34 | 
35 | 
36 | ## What DSPy Optimizers are currently available?
37 | 
38 | Optimizers can be accessed via `from dspy.teleprompt import *`.
39 | 
40 | ### Automatic Few-Shot Learning
41 | 
42 | These optimizers extend the signature by automatically generating and including **optimized** examples within the prompt sent to the model, implementing few-shot learning.
43 | 
44 | 1. [**`LabeledFewShot`**](../../api/optimizers/LabeledFewShot.md): Simply constructs few-shot examples (demos) from provided labeled input and output data points.  Requires `k` (number of examples for the prompt) and `trainset` to randomly select `k` examples from.
45 | 
46 | 2. [**`BootstrapFewShot`**](../../api/optimizers/BootstrapFewShot.md): Uses a `teacher` module (which defaults to your program) to generate complete demonstrations for every stage of your program, along with labeled examples in `trainset`. Parameters include `max_labeled_demos` (the number of demonstrations randomly selected from the `trainset`) and `max_bootstrapped_demos` (the number of additional examples generated by the `teacher`). The bootstrapping process employs the metric to validate demonstrations, including only those that pass the metric in the "compiled" prompt. Advanced: Supports using a `teacher` program that is a *different* DSPy program that has compatible structure, for harder tasks.
47 | 
48 | 3. [**`BootstrapFewShotWithRandomSearch`**](../../api/optimizers/BootstrapFewShotWithRandomSearch.md): Applies `BootstrapFewShot` several times with random search over generated demonstrations, and selects the best program over the optimization. Parameters mirror those of `BootstrapFewShot`, with the addition of `num_candidate_programs`, which specifies the number of random programs evaluated over the optimization, including candidates of the uncompiled program, `LabeledFewShot` optimized program, `BootstrapFewShot` compiled program with unshuffled examples and `num_candidate_programs` of `BootstrapFewShot` compiled programs with randomized example sets.
49 | 
50 | 4. [**`KNNFewShot`**](../../api/optimizers/KNNFewShot.md). Uses k-Nearest Neighbors algorithm to find the nearest training example demonstrations for a given input example. These nearest neighbor demonstrations are then used as the trainset for the BootstrapFewShot optimization process.
51 | 
52 | 
53 | ### Automatic Instruction Optimization
54 | 
55 | These optimizers produce optimal instructions for the prompt and, in the case of MIPROv2 can also optimize the set of few-shot demonstrations.
56 | 
57 | 5. [**`COPRO`**](../../api/optimizers/COPRO.md): Generates and refines new instructions for each step, and optimizes them with coordinate ascent (hill-climbing using the metric function and the `trainset`). Parameters include `depth` which is the number of iterations of prompt improvement the optimizer runs over.
58 | 
59 | 6. [**`MIPROv2`**](../../api/optimizers/MIPROv2.md): Generates instructions *and* few-shot examples in each step. The instruction generation is data-aware and demonstration-aware. Uses Bayesian Optimization to effectively search over the space of generation instructions/demonstrations across your modules.
60 | 
61 | 7. [**`SIMBA`**](../../api/optimizers/SIMBA.md)
62 | 
63 | 8. [**`GEPA`**](../../api/optimizers/GEPA/overview.md): Uses LM's to reflect on the DSPy program's trajectory, to identify what worked, what didn't and propose prompts addressing the gaps. Additionally, GEPA can leverage domain-specific textual feedback to rapidly improve the DSPy program. Detailed tutorials on using GEPA are available at [dspy.GEPA Tutorials](../../tutorials/gepa_ai_program/index.md).
64 | 
65 | ### Automatic Finetuning
66 | 
67 | This optimizer is used to fine-tune the underlying LLM(s).
68 | 
69 | 9. [**`BootstrapFinetune`**](/api/optimizers/BootstrapFinetune): Distills a prompt-based DSPy program into weight updates. The output is a DSPy program that has the same steps, but where each step is conducted by a finetuned model instead of a prompted LM. [See the classification fine-tuning tutorial](https://dspy.ai/tutorials/classification_finetuning/) for a complete example.
70 | 
71 | 
72 | ### Program Transformations
73 | 
74 | 10. [**`Ensemble`**](../../api/optimizers/Ensemble.md): Ensembles a set of DSPy programs and either uses the full set or randomly samples a subset into a single program.
75 | 
76 | 
77 | ## Which optimizer should I use?
78 | 
79 | Ultimately, finding the ‘right’ optimizer to use & the best configuration for your task will require experimentation. Success in DSPy is still an iterative process - getting the best performance on your task will require you to explore and iterate.  
80 | 
81 | That being said, here's the general guidance on getting started:
82 | 
83 | - If you have **very few examples** (around 10), start with `BootstrapFewShot`.
84 | - If you have **more data** (50 examples or more), try  `BootstrapFewShotWithRandomSearch`.
85 | - If you prefer to do **instruction optimization only** (i.e. you want to keep your prompt 0-shot), use `MIPROv2` [configured for 0-shot optimization](../../api/optimizers/MIPROv2.md). 
86 | - If you’re willing to use more inference calls to perform **longer optimization runs** (e.g. 40 trials or more), and have enough data (e.g. 200 examples or more to prevent overfitting) then try `MIPROv2`. 
87 | - If you have been able to use one of these with a large LM (e.g., 7B parameters or above) and need a very **efficient program**, finetune a small LM for your task with `BootstrapFinetune`.
88 | 
89 | ## How do I use an optimizer?
90 | 
91 | They all share this general interface, with some differences in the keyword arguments (hyperparameters). A full list can be found in the [API reference](../../api/optimizers/BetterTogether.md).
92 | 
93 | Let's see this with the most common one, `BootstrapFewShotWithRandomSearch`.
94 | 
95 | ```python
96 | from dspy.teleprompt import BootstrapFewShotWithRandomSearch
97 | 
98 | # Set up the optimizer: we want to "bootstrap" (i.e., self-generate) 8-shot examples of your program's steps.
99 | # The optimizer will repeat this 10 times (plus some initial attempts) before selecting its best attempt on the devset.
100 | config = dict(max_bootstrapped_demos=4, max_labeled_demos=4, num_candidate_programs=10, num_threads=4)
101 | 
102 | teleprompter = BootstrapFewShotWithRandomSearch(metric=YOUR_METRIC_HERE, **config)
103 | optimized_program = teleprompter.compile(YOUR_PROGRAM_HERE, trainset=YOUR_TRAINSET_HERE)
104 | ```
105 | 
106 | 
107 | !!! info "Getting Started III: Optimizing the LM prompts or weights in DSPy programs"
108 |     A typical simple optimization run costs on the order of $2 USD and takes around ten minutes, but be careful when running optimizers with very large LMs or very large datasets.
109 |     Optimizer runs can cost as little as a few cents or up to tens of dollars, depending on your LM, dataset, and configuration.
110 |     
111 |     === "Optimizing prompts for a ReAct agent"
112 |         This is a minimal but fully runnable example of setting up a `dspy.ReAct` agent that answers questions via
113 |         search from Wikipedia and then optimizing it using `dspy.MIPROv2` in the cheap `light` mode on 500
114 |         question-answer pairs sampled from the `HotPotQA` dataset.
115 | 
116 |         ```python linenums="1"
117 |         import dspy
118 |         from dspy.datasets import HotPotQA
119 | 
120 |         dspy.configure(lm=dspy.LM('openai/gpt-4o-mini'))
121 | 
122 |         def search(query: str) -> list[str]:
123 |             """Retrieves abstracts from Wikipedia."""
124 |             results = dspy.ColBERTv2(url='http://20.102.90.50:2017/wiki17_abstracts')(query, k=3)
125 |             return [x['text'] for x in results]
126 | 
127 |         trainset = [x.with_inputs('question') for x in HotPotQA(train_seed=2024, train_size=500).train]
128 |         react = dspy.ReAct("question -> answer", tools=[search])
129 | 
130 |         tp = dspy.MIPROv2(metric=dspy.evaluate.answer_exact_match, auto="light", num_threads=24)
131 |         optimized_react = tp.compile(react, trainset=trainset)
132 |         ```
133 | 
134 |         An informal run similar to this on DSPy 2.5.29 raises ReAct's score from 24% to 51%.
135 | 
136 |     === "Optimizing prompts for RAG"
137 |         Given a retrieval index to `search`, your favorite `dspy.LM`, and a small `trainset` of questions and ground-truth responses, the following code snippet can optimize your RAG system with long outputs against the built-in `dspy.SemanticF1` metric, which is implemented as a DSPy module.
138 | 
139 |         ```python linenums="1"
140 |         class RAG(dspy.Module):
141 |             def __init__(self, num_docs=5):
142 |                 self.num_docs = num_docs
143 |                 self.respond = dspy.ChainOfThought('context, question -> response')
144 | 
145 |             def forward(self, question):
146 |                 context = search(question, k=self.num_docs)   # not defined in this snippet, see link above
147 |                 return self.respond(context=context, question=question)
148 | 
149 |         tp = dspy.MIPROv2(metric=dspy.SemanticF1(), auto="medium", num_threads=24)
150 |         optimized_rag = tp.compile(RAG(), trainset=trainset, max_bootstrapped_demos=2, max_labeled_demos=2)
151 |         ```
152 | 
153 |         For a complete RAG example that you can run, start this [tutorial](../../tutorials/rag/index.ipynb). It improves the quality of a RAG system over a subset of StackExchange communities from 53% to 61%.
154 | 
155 |     === "Optimizing weights for Classification"
156 |         <details><summary>Click to show dataset setup code.</summary>
157 | 
158 |         ```python linenums="1"
159 |         import random
160 |         from typing import Literal
161 | 
162 |         from datasets import load_dataset
163 | 
164 |         import dspy
165 |         from dspy.datasets import DataLoader
166 | 
167 |         # Load the Banking77 dataset.
168 |         CLASSES = load_dataset("PolyAI/banking77", split="train", trust_remote_code=True).features["label"].names
169 |         kwargs = {"fields": ("text", "label"), "input_keys": ("text",), "split": "train", "trust_remote_code": True}
170 | 
171 |         # Load the first 2000 examples from the dataset, and assign a hint to each *training* example.
172 |         trainset = [
173 |             dspy.Example(x, hint=CLASSES[x.label], label=CLASSES[x.label]).with_inputs("text", "hint")
174 |             for x in DataLoader().from_huggingface(dataset_name="PolyAI/banking77", **kwargs)[:2000]
175 |         ]
176 |         random.Random(0).shuffle(trainset)
177 |         ```
178 |         </details>
179 | 
180 |         ```python linenums="1"
181 |         import dspy
182 |         lm=dspy.LM('openai/gpt-4o-mini-2024-07-18')
183 | 
184 |         # Define the DSPy module for classification. It will use the hint at training time, if available.
185 |         signature = dspy.Signature("text, hint -> label").with_updated_fields('label', type_=Literal[tuple(CLASSES)])
186 |         classify = dspy.ChainOfThought(signature)
187 |         classify.set_lm(lm)
188 | 
189 |         # Optimize via BootstrapFinetune.
190 |         optimizer = dspy.BootstrapFinetune(metric=(lambda x, y, trace=None: x.label == y.label), num_threads=24)
191 |         optimized = optimizer.compile(classify, trainset=trainset)
192 | 
193 |         optimized(text="What does a pending cash withdrawal mean?")
194 |         
195 |         # For a complete fine-tuning tutorial, see: https://dspy.ai/tutorials/classification_finetuning/
196 |         ```
197 | 
198 |         **Possible Output (from the last line):**
199 |         ```text
200 |         Prediction(
201 |             reasoning='A pending cash withdrawal indicates that a request to withdraw cash has been initiated but has not yet been completed or processed. This status means that the transaction is still in progress and the funds have not yet been deducted from the account or made available to the user.',
202 |             label='pending_cash_withdrawal'
203 |         )
204 |         ```
205 | 
206 |         An informal run similar to this on DSPy 2.5.29 raises GPT-4o-mini's score 66% to 87%.
207 | 
208 | 
209 | ## Saving and loading optimizer output
210 | 
211 | After running a program through an optimizer, it's useful to also save it. At a later point, a program can be loaded from a file and used for inference. For this, the `load` and `save` methods can be used.
212 | 
213 | ```python
214 | optimized_program.save(YOUR_SAVE_PATH)
215 | ```
216 | 
217 | The resulting file is in plain-text JSON format. It contains all the parameters and steps in the source program. You can always read it and see what the optimizer generated.
218 | 
219 | 
220 | To load a program from a file, you can instantiate an object from that class and then call the load method on it.
221 | 
222 | ```python
223 | loaded_program = YOUR_PROGRAM_CLASS()
224 | loaded_program.load(path=YOUR_SAVE_PATH)
225 | ```
226 | 
```

optimization/overview.md
```
1 | ---
2 | sidebar_position: 1
3 | ---
4 | 
5 | 
6 | # Optimization in DSPy
7 | 
8 | Once you have a system and a way to evaluate it, you can use DSPy optimizers to tune the prompts or weights in your program. Now it's useful to expand your data collection effort into building a training set and a held-out test set, in addition to the development set you've been using for exploration. For the training set (and its subset, validation set), you can often get substantial value out of 30 examples, but aim for at least 300 examples. Some optimizers accept a `trainset` only. Others ask for a `trainset` and a `valset`. When splitting data for most prompt optimizers, we recommend an unusual split compared to deep neural networks: 20% for training, 80% for validation. This reverse allocation emphasizes stable validation, since prompt-based optimizers often overfit to small training sets. In contrast, the [dspy.GEPA](https://dspy.ai/tutorials/gepa_ai_program/) optimizer follows the more standard ML convention: Maximize the training set size, while keeping the validation set just large enough to reflect the distribution of the downstream tasks (test set).
9 | 
10 | After your first few optimization runs, you are either very happy with everything or you've made a lot of progress but you don't like something about the final program or the metric. At this point, go back to step 1 (Programming in DSPy) and revisit the major questions. Did you define your task well? Do you need to collect (or find online) more data for your problem? Do you want to update your metric? And do you want to use a more sophisticated optimizer? Do you need to consider advanced features like DSPy Assertions? Or, perhaps most importantly, do you want to add some more complexity or steps in your DSPy program itself? Do you want to use multiple optimizers in a sequence?
11 | 
12 | Iterative development is key. DSPy gives you the pieces to do that incrementally: iterating on your data, your program structure, your metric, and your optimization steps. Optimizing complex LM programs is an entirely new paradigm that only exists in DSPy at the time of writing (update: there are now numerous DSPy extension frameworks, so this part is no longer true :-), so naturally the norms around what to do are still emerging. If you need help, we recently created a [Discord server](https://discord.gg/XCGy2WDCQB) for the community.
13 | 
```
