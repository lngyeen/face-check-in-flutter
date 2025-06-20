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
    -   **Find Assigned Story**: Based on the selected identity, scan the `Sprint Backlog` for an assigned story. Prioritize any story with an `InProgress` status first. If no `InProgress` story is found, take the first available `Approved` story.
        -   **If not found**: Announce "No 'Approved' or 'InProgress' stories are assigned to `[Selected Identity]`. Halting." and end the task.
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
    -   **Update Status**: In the located active sprint plan file (e.g., `docs/sprints/sprint-1-planning.md`), change the story's `Status` from `Approved` to `InProgress`.

---

### **Phase 2: Task-by-Task Implementation & Review Cycle**

1.  **Identify Phases**: The agent will treat each major `###` heading within the "Tasks / Subtasks" section of the story file as a distinct "Phase".

2.  **Begin Phase Loop**: Iterate through each identified Phase sequentially.
    -   **A. Announce Phase**: "Starting Phase: `[Phase Title]`."
    -   **B. Begin Task Loop**: For each `Task` within the current Phase:
        -   **i. Announce Task**: "Starting Task: `[Task Title]`."
        -   **ii. Execute Sub-Tasks**: Complete all sub-tasks (`- [ ]`) listed under the current Task. Implement code, write tests, and perform self-correction.
        -   **iii. Run Tests & Fix**: Run all relevant unit and widget tests. If any tests fail due to the changes, fix them until all tests pass.
        -   **iv. Update Story & Report Progress**:
            -   **Action**: Once all sub-tasks for the current Task are complete and tests are passing, update the story file by marking the main task and all its sub-tasks as complete with `[x]`.
            -   **Action**: Announce completion of the Task and provide a summary of the work done.
                -   **Announcement Template**:
                    ```
                    Task '[Task Title]' is complete.

                    **Summary of Changes:**
                    - [Summary of change 1]
                    - [List of files created/modified]

                    All changes have been saved.
                    ```
            -   **Action**: Prompt the user for the next action.
                -   **Prompt**:
                    ```
                    Please review the changes. What would you like to do next?

                    1.  **Commit & Continue**: Commit the changes and proceed to the next task.
                    2.  **Commit & Stop**: Commit the changes and end the current session.
                    3.  **Continue**: Proceed to the next task without committing.
                    4.  **Request Changes**: Provide feedback for revisions in the current task.
                    ```
            -   **Action**: HALT execution and wait for the user's explicit direction.
        -   **v. Action Execution**:
            -   **If "Commit" is chosen**:
                -   Stage all changes: `git add .`
                -   Commit with a detailed, conventional message.
                -   **Commit Message Template**:
                    ```
                    feat: Complete Story [Story ID] Task - [Task Title]

                    [Bulleted list of major accomplishments in this task]

                    Story [Story ID] Progress: Phase X, Task Y of Z complete.
                    ```
            -   **If "Continue" is chosen**: Proceed to the next task in the loop.
            -   **If "Stop" is chosen**: End the entire task cycle.
            -   **If "Request Changes" is chosen**: Await user feedback and re-work the current task based on instructions.
    -   **C. Announce Phase Completion**: Once all tasks in a phase are done, announce it. "Phase '[Phase Title]' is complete. Moving to next phase."

---

### **Phase 3: Autonomous Completion & Validation**

1.  **Post-Loop Validation**: After the development loop is complete, rigorously check all work against the story's Acceptance Criteria and the Definition of Done (DoD).
2.  **Final Test Run**: Run the entire test suite one last time to ensure end-to-end integrity.
3.  **Update Status (2nd Update)**:
    -   **Action**: Update the status in **both** locations:
        1.  In the story file (`docs/stories/....md`): Set `Status: Review`.
        2.  In the active sprint plan file: Change the story's `Status` from `InProgress` to `Review`.
    -   **Announce**: "Development for Story `[Story ID]` is complete. Status has been updated to 'Review'."

---

### **Phase 4: Autonomous Version Control & Handoff**

1.  **Execute Git Push**: `git push origin [generated-branch-name]`
2.  **Final Announce**: Announce completion, push confirmation, and readiness for the next cycle. 