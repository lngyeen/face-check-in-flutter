# DoD Validation & Customization Task - Technical Scrum Master Framework

## Purpose

To validate existing Definition of Done (DoD) for current sprint context and team needs, or create a new DoD if none exists. This task ensures quality standards are current, relevant, and aligned with team capability while supporting story creation and sprint planning workflows. The task prioritizes validation and customization over recreation to maintain consistency across sprints.

## Decision Logic - DoD Validation vs Creation

### **🔍 Primary Action: DoD Validation**
**Execute when:**
- DoD file exists in project (`docs/definition-of-done.md`)
- DoD was created recently (within last 6 months)
- Technology stack matches current project
- Team composition is similar to DoD creation context

**Validation Process:**
1. **Currency Check**: Verify DoD reflects current technology stack and project context
2. **Team Alignment**: Confirm team understanding and commitment to existing standards
3. **Sprint Customization**: Add sprint-specific quality criteria if needed
4. **Update Requirements**: Identify any necessary updates without full recreation

### **🆕 Secondary Action: DoD Creation**
**Execute only when:**
- No DoD file exists in project
- Existing DoD is severely outdated (>6 months old with major changes)
- Technology stack has changed significantly
- Team composition has changed dramatically
- Project type has evolved substantially

**Creation Triggers:**
- Missing `docs/definition-of-done.md` file
- DoD technology context doesn't match current project
- Team explicitly requests DoD refresh
- Major project pivots or technology migrations

## Inputs for this Task

### **DoD Validation Inputs:**
- **Existing DoD**: `docs/definition-of-done.md` - Current project DoD for validation
- **Sprint Context**: Current sprint goals, epic focus, and team priorities
- **Team Feedback**: Team retrospective feedback on DoD effectiveness
- **Project Evolution**: Changes in technology stack, team size, or project scope since DoD creation

### **DoD Creation Inputs** (if validation determines creation is needed):
- **DoD Template**: `bmad-agent/templates/definition-of-done-tmpl.md` - Universal template
- **Project Documentation**: Architecture, tech stack, operational guidelines
- **Team Context**: Current team size, experience level, and capabilities
- **Quality Requirements**: Performance benchmarks, security standards, compliance needs

## Task Execution Instructions

### 1. DoD Existence & Context Assessment

**Comprehensive DoD Analysis:**
- **DoD File Check:**
  - Verify existence of `docs/definition-of-done.md`
  - If missing → **ROUTE TO DoD CREATION**
  - If exists → **CONTINUE WITH VALIDATION**

- **DoD Metadata Analysis:**
  - Check DoD version, creation date, and last update
  - Assess technology stack alignment with current project
  - Evaluate team context match (size, experience, roles)
  - Review business context alignment (industry, compliance, quality focus)

- **Decision Point:**
  ```
  IF DoD exists AND current AND aligned THEN
    → Execute DoD Validation Process
  ELSE
    → Route to DoD Creation Process
  END IF
  ```

### 2. DoD Validation Process (Primary Path)

**Current DoD Assessment:**
- **Technology Alignment Validation:**
  - Verify Flutter/Dart standards are current
  - Check BLoC patterns and Clean Architecture guidelines
  - Validate mobile-specific quality standards
  - Assess face recognition and real-time processing requirements

- **Team Capability Alignment:**
  - Confirm DoD standards match current team capabilities
  - Validate testing requirements against team skills
  - Check quality metrics against team capacity
  - Assess sustainable pace considerations

- **Business Context Alignment:**
  - Verify performance benchmarks are still relevant
  - Check security requirements against current needs
  - Validate compliance requirements
  - Assess user experience standards

**Sprint-Specific Customization:**
- **Epic Context Integration:**
  - Add epic-specific quality criteria (e.g., user management security for Epic 3)
  - Emphasize relevant technology quality areas
  - Integrate business-critical quality requirements
  - Add risk-based customization for sprint goals

- **Sprint Quality Enhancement:**
  - Identify sprint-specific testing requirements
  - Add performance benchmarks for new features
  - Include integration quality standards
  - Define sprint-specific documentation requirements

### 3. DoD Creation Process (Secondary Path)

**Full DoD Creation** (only if validation determines it's necessary):
- Execute complete `Create Definition of Done Task` workflow
- Use `bmad-agent/templates/definition-of-done-tmpl.md` as foundation
- Integrate all project context and team requirements
- Create comprehensive DoD with sprint customization framework

### 4. DoD Integration & Communication

**DoD Validation Results:**
- **Validation Summary:**
  - Current DoD status (✅ Validated / ⚠️ Needs Updates / ❌ Requires Recreation)
  - Sprint customization requirements
  - Team alignment status
  - Integration readiness for story creation and sprint planning

- **Sprint Customization Document:**
  - Sprint-specific quality enhancements
  - Epic-focused quality criteria
  - Risk-based quality additions
  - Integration quality requirements

**Team Communication:**
- **DoD Reconfirmation:**
  - Present validation results to team
  - Confirm understanding of any sprint customizations
  - Address any team concerns or feedback
  - Ensure commitment to quality standards

- **Process Integration:**
  - Integrate validated DoD into story creation workflow
  - Ensure sprint planning uses current quality standards
  - Update any related checklists or templates
  - Plan continuous improvement process

## Validation Criteria

### **DoD Validation Success Criteria:**
- **Currency**: DoD reflects current project context and technology stack
- **Team Alignment**: Team understands and commits to quality standards
- **Sprint Relevance**: DoD supports current sprint goals and epic focus
- **Integration Ready**: DoD seamlessly integrates with story creation and sprint planning

### **DoD Customization Success Criteria:**
- **Sprint-Specific**: Customizations address specific sprint risks and requirements
- **Measurable**: All customizations have clear success criteria
- **Achievable**: Customizations align with team capacity and sprint timeline
- **Integrated**: Customizations enhance rather than conflict with base DoD

## Output Artifacts

### **DoD Validation Outputs:**
- **Validation Report**: `docs/current-sprint/dod-validation-report.md`
- **Sprint Customization**: `docs/current-sprint/dod-sprint-customization.md` (if needed)
- **Team Alignment Confirmation**: Documentation of team understanding and commitment

### **DoD Creation Outputs** (if validation determines creation is needed):
- **New DoD**: `docs/definition-of-done.md` (replace outdated version)
- **Creation Rationale**: Documentation of why recreation was necessary
- **Migration Guide**: Guidance for team on DoD changes

## Integration with Other Tasks

### **Story Creation Integration:**
- Validated DoD provides quality context for story acceptance criteria
- Sprint customizations inform story technical guidance
- Quality standards support story complexity assessment

### **Sprint Planning Integration:**
- Validated DoD serves as quality foundation for capacity planning
- Sprint customizations integrate into sprint risk assessment
- Quality standards inform team utilization and parallel development planning

### **Continuous Improvement:**
- Validation process identifies DoD improvement opportunities
- Sprint customizations inform future DoD updates
- Team feedback loop ensures DoD evolution with project needs

## Critical Success Factors

### **Efficiency Optimization:**
- **Validation First**: Always attempt validation before creation
- **Minimal Disruption**: Avoid unnecessary DoD recreation
- **Sprint Focus**: Prioritize sprint-specific customization over base DoD changes
- **Team Continuity**: Maintain consistent quality standards across sprints

### **Quality Assurance:**
- **Comprehensive Validation**: Thorough assessment of DoD currency and relevance
- **Team Engagement**: Active team participation in validation process
- **Context Sensitivity**: Appropriate customization for sprint and epic context
- **Integration Excellence**: Seamless integration with story creation and sprint planning workflows 