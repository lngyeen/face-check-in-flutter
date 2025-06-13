# Create Definition of Done Task - Technical Scrum Master Framework

## Purpose

To establish comprehensive, measurable quality standards that ensure consistent delivery excellence across all sprints while balancing team capability with business requirements. This task creates a foundational Definition of Done (DoD) that serves as the quality backbone for all story creation and sprint planning activities, optimized for both team sustainability and technical excellence.

## ⚠️ IMPORTANT: When to Use This Task

### **PRIMARY USAGE: New Projects Only**
This task should be executed ONLY when:
- **No DoD exists**: Project lacks `docs/definition-of-done.md` file
- **Major project pivot**: Fundamental technology stack change (e.g., switching from web to mobile)
- **Team rebuild**: Complete team replacement requiring new quality standards
- **Compliance change**: New regulatory requirements necessitating DoD recreation

### **⛔ DO NOT USE when:**
- DoD already exists in project
- Making incremental updates to existing DoD
- Customizing DoD for specific sprint needs
- DoD is current but needs validation

### **✅ INSTEAD USE: `bmad-agent/tasks/dod-validation-task.md`**
For projects with existing DoD, use the DoD Validation Task which:
- Validates existing DoD currency and relevance
- Adds sprint-specific customizations
- Ensures team alignment with existing standards
- Avoids unnecessary DoD recreation

## Enhanced Capabilities & Integration

### **Technical Scrum Master Excellence:**
- **Quality Foundation Creation**: Establishes measurable quality standards that support both story creation and sprint planning workflows
- **Team Capability Alignment**: Balances ambitious quality goals with realistic team capacity and growth trajectory  
- **Technology-Specific Standards**: Integrates technology stack requirements (Flutter, Clean Architecture, etc.) into quality criteria
- **Continuous Improvement**: Creates framework for DoD evolution based on team maturity and project complexity
- **Sprint Planning Integration**: Ensures DoD supports parallel development optimization and team utilization goals

### **Cross-Workflow Integration:**
- **Story Creation Support**: Provides quality context for story acceptance criteria and technical guidance
- **Sprint Planning Foundation**: Establishes quality baseline for capacity planning and risk assessment
- **Developer Handoff**: Creates clear quality expectations for development team execution
- **Stakeholder Communication**: Provides transparent quality commitments for business stakeholder alignment

## Inputs for this Task

### **Framework Template Assets:**
- **Definition of Done Template**: `bmad-agent/templates/definition-of-done-tmpl.md` - Universal template adaptable for any technology stack and industry domain
- **Template Configuration**: Project context settings for technology, industry, team size, and quality focus
- **Story Template Integration**: `bmad-agent/templates/story-tmpl.md` - Integration points for DoD references
- **Sprint Planning Template**: `bmad-agent/templates/sprint-planning-tmpl.md` - Quality section customization
- **Validation Checklists**: Sprint planning and story creation checklists requiring DoD integration

### **Project Documentation Analysis:**
- **Technical Standards**: `docs/operational-guidelines.md` - Coding standards, error handling, security practices
- **Testing Framework**: `docs/testing-strategy.md` - QA approach, testing protocols, coverage requirements
- **Architecture Quality**: `docs/architecture.md` - System design standards, performance requirements
- **Technology Constraints**: `docs/tech-stack.md` - Technology-specific requirements, dependency versions
- **Deployment Standards**: `docs/deployment-guide.md` - Environment promotion, release criteria
- **API Quality Standards**: `docs/api-reference.md` - Communication protocol compliance, performance standards

### **Team & Project Context:**
- **Existing Story Analysis**: Pattern analysis from `docs/stories/` to understand current quality practices
- **Team Capability Assessment**: Historical velocity, skill levels, available capacity for quality activities
- **Technology Context**: Flutter/Dart specific quality requirements, mobile development standards
- **Business Context**: Face recognition accuracy requirements, real-time performance standards
- **Compliance Requirements**: Security standards, performance benchmarks, accessibility requirements

### **Quality Metrics & Standards:**
- **Performance Benchmarks**: App load time, API response time, real-time processing latency
- **Code Quality Metrics**: Coverage thresholds, code complexity, maintainability indices  
- **Security Standards**: Authentication, data protection, secure communication protocols
- **User Experience Standards**: Accessibility, cross-platform compatibility, error handling

## Task Execution Instructions

### 1. Project Context & Quality Standards Analysis

**Comprehensive Documentation Review:**
- **Acknowledge Task Initiation:** 
  - Confirm "Create Definition of Done Task - Technical Scrum Master Framework" is being initiated
  - State integration with story creation and sprint planning workflows
  - Begin systematic quality standards analysis across all project documentation

- **Technical Standards Assessment:**
  - **Coding Standards**: Extract specific quality criteria from `operational-guidelines.md`
  - **Testing Requirements**: Analyze testing strategy for coverage thresholds, testing types, quality gates
  - **Architecture Compliance**: Review architecture document for performance, scalability, security requirements
  - **Technology Constraints**: Identify Flutter-specific quality requirements and mobile development standards
  - **Deployment Quality**: Extract environment promotion criteria and release readiness standards

- **Existing Quality Patterns Analysis:**
  - **Story Pattern Review**: Analyze existing stories in `docs/stories/` for implicit quality standards
  - **Acceptance Criteria Analysis**: Extract common quality themes from story acceptance criteria
  - **Technical Debt Patterns**: Identify recurring quality issues for proactive prevention
  - **Integration Quality**: Assess quality standards for WebSocket communication, face recognition accuracy

### 2. Team Capability & Context Assessment

**Team-Aligned Quality Standards:**
- **Historical Performance Analysis:**
  - Review previous sprint completion rates and quality delivery patterns
  - Assess team's capacity for quality activities (testing, review, documentation)
  - Identify team strengths and areas requiring quality support
  - Evaluate learning curve for new quality practices

- **Technology Context Integration:**
  - **Flutter Development Standards**: Mobile app quality requirements, cross-platform consistency
  - **Clean Architecture Compliance**: Layer separation, dependency injection, testing pyramid
  - **Real-time System Quality**: WebSocket stability, face recognition accuracy, performance consistency
  - **Integration Quality**: Backend communication, error handling, offline capability

- **Sustainable Quality Target Setting:**
  - Balance ambitious quality goals with realistic team capacity
  - Account for learning time for new quality practices
  - Plan quality improvement trajectory over multiple sprints
  - Establish baseline metrics for continuous improvement tracking

### 3. Base Definition of Done Creation

**Comprehensive DoD Framework Development:**

#### **Template Configuration & Customization:**
- **Load Universal Template**: Load `bmad-agent/templates/definition-of-done-tmpl.md` as foundation
- **Project Context Configuration**: Complete template configuration section based on:
  - **Technology Stack**: Configure for actual project technology (e.g., Mobile for Flutter, Web Frontend for React)
  - **Project Type**: Configure based on project phase (e.g., Feature Enhancement, Greenfield)
  - **Industry Domain**: Configure based on business context (e.g., Healthcare for patient data, Consumer Software)
  - **Team Context**: Configure for actual team size, experience level, and quality focus areas
- **Template Section Selection**: Activate relevant template sections and deactivate non-applicable sections

#### **Template Customization with Project Context:**
- **Base Quality Standards Customization**: Adapt universal standards to project-specific requirements using gathered documentation
- **Technology-Specific Standards Activation**: Select and customize relevant technology sections (Web Frontend, Mobile, Backend/API, etc.)
- **Industry-Specific Standards Integration**: Add industry-specific requirements if applicable (Healthcare, Financial, etc.)
- **Process Standards Alignment**: Align process quality standards with existing team workflows and project management approach

#### **Project-Specific Content Integration:**
- **Performance Benchmarks**: Integrate specific performance targets from architecture and requirements documentation
- **Security Requirements**: Integrate security standards from operational guidelines and compliance requirements
- **Quality Metrics**: Define measurable quality criteria based on project success factors and team capability
- **Integration Standards**: Define quality standards for WebSocket communication, API interactions, and system integration points

### 4. Sprint Customization Framework

**Adaptive DoD for Sprint Context:**

#### **Sprint-Specific Enhancement Process:**
- **Epic Context Integration**: Add epic-specific quality criteria (e.g., authentication security for Epic 1)
- **Technology Focus Areas**: Emphasize relevant technology quality (e.g., camera integration for Epic 2)
- **Business Value Alignment**: Integrate business-critical quality requirements for sprint goals
- **Risk-Based Customization**: Add quality criteria for identified sprint risks

#### **Parallel Development Quality Support:**
- **Independent Work Stream Quality**: Ensure quality standards support parallel development
- **Integration Point Quality**: Define quality criteria for stream integration and coordination
- **Cross-Stream Consistency**: Maintain quality consistency across parallel work streams
- **Communication Quality**: Quality standards for cross-stream communication and synchronization

### 5. DoD Documentation & Communication

**Comprehensive Documentation Creation:**

#### **Definition of Done Document Structure:**
```markdown
# Definition of Done - Face Check-in Flutter Project

## Base Quality Standards (All Stories)
### Code Quality
### Testing Excellence  
### Documentation Standards
### Security Compliance
### Performance Standards

## Technology-Specific Standards (Flutter/Mobile)
### Cross-Platform Quality
### Mobile Performance
### UI/UX Standards
### Device Testing

## Project-Specific Standards (Face Recognition)
### Face Recognition Accuracy
### Real-time Performance
### System Integration
### User Experience

## Process Quality Standards
### DoD Validation Process
### Quality Gate Enforcement
### Continuous Improvement
### Team Communication

## Sprint Customization Framework
### Enhancement Process
### Epic Context Integration
### Risk-Based Additions
### Parallel Development Support
```

#### **Integration with Existing Templates:**
- **Story Template Integration**: Update story template to reference DoD validation
- **Sprint Planning Integration**: Ensure DoD customization process is included in sprint planning
- **Checklist Updates**: Update validation checklists to include DoD compliance verification

### 6. Team Validation & Rollout

**Collaborative DoD Finalization:**

#### **Team Review & Feedback Process:**
- **DoD Presentation**: Present comprehensive DoD to development team for review
- **Feasibility Assessment**: Validate DoD achievability with team capacity and capability
- **Adjustment Integration**: Incorporate team feedback for realistic and sustainable standards
- **Consensus Building**: Ensure team commitment to DoD standards and validation processes

#### **Stakeholder Communication:**
- **Quality Commitment Communication**: Present DoD to stakeholders as quality delivery commitment
- **Business Value Alignment**: Explain how DoD supports business objectives and risk mitigation
- **Continuous Improvement Plan**: Outline DoD evolution process based on team maturity and project needs

#### **Implementation Planning:**
- **DoD Integration Timeline**: Plan integration with existing story creation and sprint planning workflows
- **Team Training**: Identify training needs for new quality practices and tools
- **Metrics Baseline**: Establish baseline measurements for DoD effectiveness tracking
- **Continuous Improvement Process**: Define retrospective integration and DoD enhancement process

## Critical Success Factors

### **DoD Quality Characteristics:**
- **Measurable**: All criteria have clear, objective success measures
- **Achievable**: Standards align with team capability and available time
- **Comprehensive**: Covers all critical quality dimensions for project success
- **Technology-Aligned**: Integrates Flutter/mobile development best practices
- **Business-Relevant**: Supports business objectives and risk mitigation

### **Integration Success:**
- **Story Creation**: DoD seamlessly integrates with story acceptance criteria development
- **Sprint Planning**: DoD provides quality foundation for capacity planning and risk assessment
- **Team Workflow**: DoD enhances rather than burdens existing development processes
- **Stakeholder Value**: DoD provides transparent quality commitments and delivery confidence

### **Continuous Improvement:**
- **Metrics-Driven**: DoD effectiveness measured and improved over time
- **Team Evolution**: DoD evolves with team maturity and capability growth
- **Project Adaptation**: DoD adapts to changing project requirements and technology constraints
- **Quality Culture**: DoD supports development of sustainable quality culture and practices 