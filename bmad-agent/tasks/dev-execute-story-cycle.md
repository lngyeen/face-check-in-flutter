# Task: Developer Story Execution Cycle

**Objective**: To provide a standardized, end-to-end workflow that consolidates initial user interaction, followed by autonomous implementation and completion of an assigned story.

---

### **Phase 1: Pre-flight Check & User Confirmation**

1.  **User Trigger**: The user initiates the task (e.g., via the `*next-story` command).

2.  **Locate Active Sprint Plan & Identify Team**:
    -   **Action**: Scan the `docs/sprints/` directory for the latest sprint plan.
    -   **Action**: Read the sprint plan and parse the 'Team Composition' table to extract a list of all available developer roles (e.g., `Senior Dev #1`, `Junior Dev #2`).

3.  **Consolidated Questions**:
    -   **Action**: Present a single, consolidated list of questions to the user.
    -   **Question Block**:
        ```
        Starting story execution cycle. Please provide the following details:

        1.  **Developer Identity**: Please select my developer role from the list below:
            [Dynamically generated list of developer roles from sprint plan]
        2.  **Specific Instructions (Optional)**: Are there any other specific instructions or files to focus on for this story?
        ```

4.  **Setup & Verification**:
    -   **Action**: Once the user provides the inputs, perform internal setup.
    -   **Find Assigned Story**: Based on the selected identity, scan the `Sprint Backlog` for the first `Approved` story assigned to that role.
        -   **If not found**: Announce "No 'Approved' stories are assigned to `[Selected Identity]`. Halting." and end the task.
        -   **If found**: 
            - Announce the story: "Found assigned story: `[Story ID] - [Story Title]`."
            - **Action**: Load the corresponding story file (path from the `Story File` column) to prepare for implementation.

5.  **Intelligent Branch Creation**:
    -   **Action**: Analyze the story's title to determine the appropriate branch prefix.
        - **Logic**: Scan the story title for keywords.
            - `bug`, `fix`, `error`, `issue` -> `bug/`
            - `docs`, `documentation`, `readme` -> `docs/`
            - `chore`, `refactor`, `build`, `test`, `style`, `perf` -> `chore/`
            - **Default**: `feature/`
    -   **Action**: Automatically generate a new branch name based on the determined prefix and story details.
    -   **Naming Convention**: `<prefix>story-<story_id>-<kebab-case-title>`
    -   **Example**: "Story 1.1: Project Foundation..." defaults to `feature/story-1.1-project-foundation`
    -   **Execute**: Run `git checkout -b [generated-branch-name]`.

6.  **Execution Plan & Lock-in**:
    -   **Action**: Announce the final plan before beginning autonomous work.
    -   **Announce**: "Confirmation complete. I will now proceed as `[Your Identity]` on the newly created branch `[Generated Branch Name]`. I will now begin implementing `[Story Title]`. I will operate autonomously and only request further input if a critical blocker is encountered."
    -   **Update Status**: In the located active sprint plan file (e.g., `docs/sprints/sprint-1-planning.md`), change the story's `Status` from `Approved` to `In Progress`.

---

### **Phase 2: Autonomous & Incremental Development Cycle**

1.  **Initiate Development Loop**: Begin iterating through each sub-task in the loaded story file. This loop is the core of autonomous development.
2.  **Execute Sub-Task Workflow (for each sub-task)**:
    -   **A. Announce**: Clearly state the current focus: "Starting Task `[Task #]`: `[Task Description]`."
    -   **B. Implement & Test**: Write or modify code, create necessary tests, and ensure the implementation directly addresses the sub-task requirements.
    -   **C. Self-Correct**: Run all relevant tests. If failures occur, analyze the root cause, apply fixes, and re-test until all tests for the current sub-task pass.
    -   **D. CRITICAL: Document & Commit Progress**: This step is mandatory after each sub-task is completed and validated.
        -   **i. Update Story File**:
            -   **Action**: Modify the story markdown file (`docs/stories/...`).
            -   Mark the completed sub-task with `[x]`.
            -   Add concise, meaningful progress notes directly under the sub-task.
        -   **ii. Stage and Commit Changes**:
            -   **Action**: Stage all modified files, including the updated story file: `git add .`.
            -   **Action**: Commit using the standardized conventional commit format. The commit MUST bundle the code changes *and* the story file update together.
            -   **Commit Message Template**:
                ```
                feat: Complete Story [Story ID] Task [#] - [Sub-task Title]

                - [Detailed implementation note 1 about code changes]
                - [Detailed implementation note 2 if necessary]

                Story [Story ID] Progress: [X/Y] tasks complete.
                ```

---

### **Phase 3: Autonomous Completion & Validation**

1.  **Post-Loop Validation**: After the development loop is complete, rigorously check all work against the story's Acceptance Criteria and the Definition of Done (DoD).
2.  **Update Status (2nd Update)**:
    -   **Action**: Update the status in **both** locations:
        1.  In the story file (`docs/stories/....md`): Set `Status: Review`.
        2.  In the active sprint plan file: Change the story's `Status` from `In Progress` to `Review`.
    -   **Announce**: "Development for Story `[Story ID]` is complete. Status has been updated to 'Review'."

---

### **Phase 4: Autonomous Version Control & Handoff**

1.  **Execute Git Push**: `git push origin [generated-branch-name]`
2.  **Final Announce**: Announce completion, push confirmation, and readiness for the next cycle. 