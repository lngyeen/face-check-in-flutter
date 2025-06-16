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
        -   **If found**: Announce the story: "Found assigned story: `[Story ID] - [Story Title]`."

5.  **Autonomous Branch Creation**:
    -   **Action**: Automatically generate a new branch name based on the story details.
    -   **Naming Convention**: `story-<story_id>-<kebab-case-title>`
    -   **Example**: From "Story 1.1: Project Foundation..." -> `story-1.1-project-foundation`
    -   **Execute**: Run `git checkout -b [generated-branch-name]`.

6.  **Execution Plan & Lock-in**:
    -   **Action**: Announce the final plan before beginning autonomous work.
    -   **Announce**: "Confirmation complete. I will now proceed as `[Your Identity]` on the newly created branch `[Generated Branch Name]`. I will now begin implementing `[Story Title]`. I will operate autonomously and only request further input if a critical blocker is encountered."
    -   **Update Status**: In the located active sprint plan file (e.g., `docs/sprints/sprint-1-planning.md`), change the story's `Status` from `Approved` to `In Progress`.
    -   **Load Story Details**: Read the corresponding story file to begin implementation.

---

### **Phase 2: Autonomous Development & Implementation**

1.  **Analyze Requirements**: Analyze Acceptance Criteria (ACs) and sub-tasks.
2.  **Code Implementation**: Create/edit files, write logic and tests.
3.  **Self-Correction & Iteration**: Run tests, analyze failures, and apply fixes.
4.  **Update Task Checklist**: Mark completed sub-tasks in the story file.

---

### **Phase 3: Autonomous Completion & Validation**

1.  **Validate against Definition of Done (DoD)**: Rigorously check work against the Definition of Done.
2.  **Update Status (2nd Update)**:
    -   **Action**: Update the status in **both** locations:
        1.  In the story file (`docs/stories/....md`): Set `Status: Review`.
        2.  In the active sprint plan file: Change the story's `Status` from `In Progress` to `Review`.
    -   **Announce**: "Development for Story `[Story ID]` is complete. Status has been updated to 'Review'."

---

### **Phase 4: Autonomous Version Control & Handoff**

1.  **Generate Commit Message**: Construct a Conventional Commit message.
2.  **Execute Git Flow**: `git add .`, `git commit -m "..."`, `git push`.
3.  **Final Announce**: Announce completion, commit hash, and readiness for the next cycle. 