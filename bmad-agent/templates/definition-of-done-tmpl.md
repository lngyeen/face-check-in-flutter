# Definition of Done Template - Universal Technical Scrum Master Framework

## 🔧 **Template Configuration** *(Complete before DoD creation)*

**Project Context Settings:**
- [ ] **Technology Stack**: [ ] Web Frontend [ ] Backend/API [ ] Mobile [ ] Full-Stack [ ] Machine Learning [ ] DevOps/Infrastructure [ ] Desktop [ ] Other: [_____]
- [ ] **Project Type**: [ ] Greenfield [ ] Feature Enhancement [ ] Legacy Modernization [ ] Maintenance Mode [ ] POC/MVP [ ] Enterprise Integration
- [ ] **Industry Domain**: [ ] Consumer Software [ ] Enterprise SaaS [ ] Healthcare/Medical [ ] Financial/Banking [ ] E-commerce [ ] Government/Public Sector [ ] Gaming [ ] Other: [_____]
- [ ] **Team Size**: [ ] 2-3 people [ ] 4-7 people [ ] 8-15 people [ ] 15+ people *(Enterprise scale)*
- [ ] **Team Experience**: [ ] New to Scrum [ ] Intermediate [ ] Advanced [ ] Expert Level
- [ ] **Compliance Requirements**: [ ] SOC2 [ ] HIPAA [ ] GDPR [ ] PCI-DSS [ ] Government/Military [ ] None [ ] Other: [_____]
- [ ] **Quality Focus**: [ ] High Performance [ ] High Security [ ] High Availability [ ] User Experience [ ] Data Integrity [ ] Scalability [ ] Other: [_____]

## 📋 **Project Overview**

**Project Name**: [Project Name]  
**Team**: [Team Name/Identifier]  
**DoD Version**: [Version] *(e.g., v1.0, v2.1)*  
**Created Date**: [YYYY-MM-DD]  
**Last Updated**: [YYYY-MM-DD]  
**Next Review Date**: [YYYY-MM-DD] *(Recommend quarterly or after major changes)*  
**Approved By**: [Team Members/Stakeholders]  

**Project Context**: [Brief description based on industry domain and project type]  
**Quality Commitment**: [High-level quality statement aligned with business objectives]

## 🎯 **Base Quality Standards** *(Universal - All Stories)*

### **Code Quality**
- [ ] **Code Review**: All code changes reviewed by ≥[1] team member(s) before merge
- [ ] **Coding Standards**: Code follows established [language/framework] coding standards and style guide
- [ ] **Code Documentation**: 
  - [ ] Public APIs documented with clear examples
  - [ ] Complex logic documented with inline comments
  - [ ] README/documentation updated for new features
- [ ] **Code Maintainability**: 
  - [ ] No code smells or technical debt introduced without explicit approval
  - [ ] Cyclomatic complexity within acceptable limits *(≤[10] per function)*
  - [ ] Functions/methods follow single responsibility principle
- [ ] **Version Control**: 
  - [ ] Meaningful commit messages following [conventional commits/team standard]
  - [ ] No direct commits to main/master branch
  - [ ] Branch naming follows team conventions

### **Testing Excellence**
- [ ] **Unit Testing**: 
  - [ ] Unit tests written for all new/modified business logic
  - [ ] Minimum [80]% code coverage maintained
  - [ ] Tests follow AAA pattern (Arrange, Act, Assert) or equivalent
  - [ ] All tests pass in CI/CD pipeline
- [ ] **Integration Testing**: 
  - [ ] API endpoints tested for expected behavior
  - [ ] Database interactions tested where applicable
  - [ ] Third-party service integrations tested (with mocks/stubs)
- [ ] **End-to-End Testing**: 
  - [ ] Critical user paths tested *(based on project complexity)*
  - [ ] Cross-browser/platform compatibility verified *(where applicable)*
- [ ] **Test Automation**: 
  - [ ] Tests run automatically in CI/CD pipeline
  - [ ] Test failures block deployment to production
  - [ ] Performance/load tests included for critical paths *(where applicable)*

### **Documentation Standards**
- [ ] **Technical Documentation**: 
  - [ ] Architecture decisions documented (ADRs where applicable)
  - [ ] API documentation updated for new/modified endpoints
  - [ ] Database schema changes documented
- [ ] **User Documentation**: 
  - [ ] User-facing features documented in user guide/help system
  - [ ] Release notes updated with user-visible changes
- [ ] **Developer Documentation**: 
  - [ ] Setup/installation instructions updated
  - [ ] Development environment setup verified
  - [ ] Troubleshooting guide updated for common issues

### **Security & Privacy**
- [ ] **Security Review**: 
  - [ ] Code reviewed for security vulnerabilities
  - [ ] Input validation implemented for all user inputs
  - [ ] Authentication/authorization requirements met
  - [ ] Sensitive data handling follows security standards
- [ ] **Privacy Compliance**: 
  - [ ] Data collection/processing complies with privacy regulations *(GDPR, CCPA, etc.)*
  - [ ] User consent mechanisms implemented where required
  - [ ] Data retention policies followed
- [ ] **Security Testing**: 
  - [ ] Security scan passes with no high/critical vulnerabilities
  - [ ] Dependency vulnerability scan passes
  - [ ] Penetration testing completed *(for high-risk changes)*

### **Performance & Reliability**
- [ ] **Performance Standards**: 
  - [ ] Application load time ≤[3] seconds
  - [ ] API response time ≤[500]ms for standard operations
  - [ ] Database query performance optimized
  - [ ] No memory leaks or resource exhaustion
- [ ] **Reliability Standards**: 
  - [ ] Error handling implemented for all failure scenarios
  - [ ] Graceful degradation for external service failures
  - [ ] Logging implemented for debugging and monitoring
  - [ ] Health checks implemented for critical services
- [ ] **Scalability Considerations**: 
  - [ ] Code designed to handle expected load
  - [ ] Database queries optimized for scale
  - [ ] Resource usage (CPU, memory, disk) within acceptable limits

## 🛠️ **Technology-Specific Standards** *(Configure based on technology stack)*

### **Web Frontend Standards** *(If applicable)*
- [ ] **Browser Compatibility**: Works on [Chrome, Firefox, Safari, Edge] latest versions
- [ ] **Responsive Design**: Functions correctly on [desktop, tablet, mobile] screen sizes
- [ ] **Accessibility**: Meets [WCAG 2.1 AA] accessibility standards
- [ ] **Performance**: 
  - [ ] Lighthouse score ≥[90] for performance
  - [ ] First Contentful Paint ≤[2] seconds
  - [ ] Time to Interactive ≤[3] seconds
- [ ] **SEO**: Meta tags, structured data implemented where applicable
- [ ] **Progressive Enhancement**: Core functionality works without JavaScript

### **Backend/API Standards** *(If applicable)*
- [ ] **API Design**: RESTful design principles followed or GraphQL schema valid
- [ ] **Data Validation**: Input validation on all API endpoints
- [ ] **Error Handling**: Consistent error response format with appropriate HTTP status codes
- [ ] **Authentication**: Secure authentication/authorization implemented
- [ ] **Rate Limiting**: API rate limiting implemented to prevent abuse
- [ ] **Monitoring**: API performance monitoring and alerting configured
- [ ] **Documentation**: API documentation (OpenAPI/Swagger) updated

### **Mobile Standards** *(If applicable)*
- [ ] **Platform Compatibility**: Tested on [iOS 14+, Android 8+] or equivalent
- [ ] **Device Testing**: Tested on physical devices, not just simulators
- [ ] **Performance**: 
  - [ ] App launch time ≤[3] seconds
  - [ ] Battery usage optimized
  - [ ] Memory usage within platform guidelines
- [ ] **Offline Capability**: Graceful handling of network connectivity issues
- [ ] **App Store Guidelines**: Compliance with platform-specific guidelines
- [ ] **Push Notifications**: Proper handling of notification permissions and delivery

### **Database Standards** *(If applicable)*
- [ ] **Data Integrity**: Foreign key constraints and data validation rules enforced
- [ ] **Migration Scripts**: Database schema changes implemented via migration scripts
- [ ] **Backup Strategy**: Database backup and recovery procedures tested
- [ ] **Performance**: Query performance optimized with appropriate indexes
- [ ] **Security**: Database access controls and encryption implemented
- [ ] **Monitoring**: Database performance monitoring configured

### **DevOps/Infrastructure Standards** *(If applicable)*
- [ ] **Infrastructure as Code**: All infrastructure defined in version-controlled code
- [ ] **CI/CD Pipeline**: Automated build, test, and deployment pipeline configured
- [ ] **Monitoring**: Application and infrastructure monitoring configured
- [ ] **Logging**: Centralized logging with appropriate log levels
- [ ] **Security**: Security scanning integrated into CI/CD pipeline
- [ ] **Disaster Recovery**: Backup and disaster recovery procedures documented and tested

## 🏢 **Industry-Specific Standards** *(Configure based on industry domain)*

### **Healthcare/Medical Standards** *(If applicable)*
- [ ] **HIPAA Compliance**: Patient data handling meets HIPAA requirements
- [ ] **Data Encryption**: PHI encrypted at rest and in transit
- [ ] **Audit Logging**: All data access logged for compliance auditing
- [ ] **Access Controls**: Role-based access control implemented
- [ ] **Incident Response**: Healthcare data breach response plan followed

### **Financial/Banking Standards** *(If applicable)*
- [ ] **PCI-DSS Compliance**: Payment card data handling meets PCI-DSS requirements
- [ ] **Financial Regulations**: Compliance with relevant financial regulations
- [ ] **Data Retention**: Financial data retention policies followed
- [ ] **Fraud Prevention**: Fraud detection and prevention measures implemented
- [ ] **Audit Trail**: Complete audit trail for all financial transactions

### **E-commerce Standards** *(If applicable)*
- [ ] **Payment Security**: Secure payment processing implemented
- [ ] **Order Management**: Order processing and inventory management integrated
- [ ] **User Experience**: Shopping cart and checkout process optimized
- [ ] **Performance**: Site performance optimized for conversion
- [ ] **Analytics**: E-commerce tracking and analytics implemented

### **Government/Public Sector Standards** *(If applicable)*
- [ ] **Accessibility**: Section 508/WCAG compliance for government websites
- [ ] **Security**: Government security standards and protocols followed
- [ ] **Data Classification**: Data classified according to government standards
- [ ] **Transparency**: Open data and transparency requirements met
- [ ] **Privacy**: Government privacy regulations compliance

## 📊 **Process Quality Standards**

### **Development Process**
- [ ] **Story/Task Tracking**: All work tracked in project management system
- [ ] **Acceptance Criteria**: All acceptance criteria met and validated
- [ ] **Peer Review**: Code/design reviewed by appropriate team members
- [ ] **Stakeholder Approval**: Stakeholder sign-off obtained for user-facing changes
- [ ] **Risk Assessment**: Technical and business risks identified and mitigated

### **Quality Assurance Process**
- [ ] **Testing Strategy**: Appropriate testing strategy implemented based on risk
- [ ] **Bug Tracking**: All defects tracked and resolved or explicitly deferred
- [ ] **Regression Testing**: Regression testing completed for critical functionality
- [ ] **User Acceptance**: User acceptance testing completed where applicable
- [ ] **Performance Testing**: Performance testing completed for critical paths

### **Deployment Process**
- [ ] **Deployment Validation**: Deployment process validated in non-production environment
- [ ] **Rollback Plan**: Rollback plan documented and tested
- [ ] **Environment Configuration**: Environment-specific configurations verified
- [ ] **Monitoring**: Post-deployment monitoring confirms successful deployment
- [ ] **Communication**: Deployment communicated to relevant stakeholders

### **Documentation Process**
- [ ] **Change Documentation**: All changes documented in appropriate format
- [ ] **Knowledge Transfer**: Knowledge transfer completed for complex changes
- [ ] **Runbook Updates**: Operational runbooks updated for new functionality
- [ ] **Training Materials**: Training materials updated where applicable

## 🔄 **Continuous Improvement Standards**

### **Metrics & Measurement**
- [ ] **Quality Metrics**: Quality metrics tracked and trending in right direction
  - [ ] Defect density: ≤[X] defects per 1000 lines of code
  - [ ] Code coverage: ≥[80]% maintained
  - [ ] Customer satisfaction: ≥[X] rating maintained
- [ ] **Performance Metrics**: Performance metrics within acceptable ranges
  - [ ] Response time: ≤[X]ms for [Y]% of requests
  - [ ] Uptime: ≥[99.9]% system availability
  - [ ] Error rate: ≤[X]% error rate maintained
- [ ] **Team Metrics**: Team velocity and productivity metrics tracked
  - [ ] Sprint commitment: ≥[80]% of committed work completed
  - [ ] Code review turnaround: ≤[X] hours average
  - [ ] Deployment frequency: [X] deployments per [time period]

### **Learning & Adaptation**
- [ ] **Retrospectives**: Regular retrospectives conducted with action items
- [ ] **Knowledge Sharing**: Technical knowledge shared across team
- [ ] **Best Practices**: Industry best practices researched and adopted
- [ ] **Tool Evaluation**: Development tools and processes regularly evaluated
- [ ] **Training**: Team training needs identified and addressed

### **Technical Debt Management**
- [ ] **Debt Tracking**: Technical debt items identified and tracked
- [ ] **Debt Prioritization**: Technical debt prioritized based on impact and effort
- [ ] **Debt Allocation**: [15-20]% of sprint capacity allocated to technical debt
- [ ] **Debt Metrics**: Technical debt metrics tracked over time
- [ ] **Refactoring**: Regular refactoring to maintain code quality

## 🎯 **Sprint Customization Framework**

### **Epic/Theme-Specific Enhancements**
**Instructions**: Add epic-specific quality criteria during sprint planning

**Example Epic Enhancements:**
- **Authentication Epic**: Additional security testing, penetration testing
- **Payment Processing Epic**: PCI compliance validation, fraud testing
- **Performance Epic**: Load testing, optimization validation
- **Integration Epic**: End-to-end testing, API contract validation

### **Risk-Based Customizations**
**Instructions**: Add quality criteria based on identified sprint risks

**Risk Categories:**
- **High Complexity**: Additional code review, architecture validation
- **External Dependencies**: Integration testing, fallback validation
- **New Technology**: Spike validation, learning documentation
- **Critical Path**: Additional testing, deployment validation

### **Team Context Adaptations**
**Instructions**: Adjust DoD based on team experience and capacity

**Team Adaptations:**
- **New Team Members**: Pair programming, mentoring documentation
- **Remote Team**: Additional communication protocols, documentation
- **Part-Time Team**: Flexible timeline, handoff documentation
- **Cross-Functional Team**: Cross-training, knowledge sharing

### **Business Context Enhancements**
**Instructions**: Add business-critical quality criteria

**Business Enhancements:**
- **Revenue Impact**: Additional testing, rollback procedures
- **Customer Facing**: UX testing, accessibility validation
- **Compliance Deadline**: Audit trail, compliance documentation
- **Competitive Feature**: Market research validation, competitive analysis

## 📋 **DoD Validation Checklist**

### **Story Completion Validation**
- [ ] All acceptance criteria met and validated
- [ ] All DoD criteria completed or explicitly deferred with justification
- [ ] Stakeholder sign-off obtained where required
- [ ] Story marked as complete in project management system

### **Quality Gate Validation**
- [ ] All automated tests passing
- [ ] Code review completed and approved
- [ ] Security scan completed with acceptable results
- [ ] Performance benchmarks met
- [ ] Documentation updated and reviewed

### **Deployment Readiness**
- [ ] Feature flagged or ready for production deployment
- [ ] Monitoring and alerting configured
- [ ] Rollback plan documented and tested
- [ ] Communication plan executed
- [ ] Post-deployment validation plan prepared

## 📈 **DoD Evolution & Maintenance**

### **Regular Review Process**
- [ ] **Quarterly Reviews**: DoD reviewed quarterly for effectiveness
- [ ] **Project Milestone Reviews**: DoD updated at major project milestones
- [ ] **Technology Changes**: DoD updated when technology stack changes
- [ ] **Team Changes**: DoD updated when team composition changes significantly

### **Continuous Improvement Integration**
- [ ] **Retrospective Integration**: DoD improvements identified in retrospectives
- [ ] **Metrics-Driven Updates**: DoD updated based on quality metrics trends
- [ ] **Industry Best Practices**: DoD updated with industry best practices
- [ ] **Tool Integration**: DoD updated when new tools are adopted

### **Stakeholder Communication**
- [ ] **Team Communication**: DoD changes communicated to entire team
- [ ] **Stakeholder Updates**: DoD changes communicated to relevant stakeholders
- [ ] **Training Updates**: Team training updated when DoD changes significantly
- [ ] **Documentation Updates**: DoD template and examples updated regularly

---

## 🎯 **Template Usage Instructions**

### **Initial Setup**
1. Complete the **Template Configuration** section based on your project context
2. Customize the **Base Quality Standards** for your team's capability and project requirements
3. Select and customize relevant **Technology-Specific Standards** sections
4. Add **Industry-Specific Standards** if applicable
5. Review and adjust **Process Quality Standards** for your team's workflow

### **Sprint Planning Integration**
1. Review base DoD at start of each sprint planning session
2. Add **Sprint Customization** based on epic focus and identified risks
3. Validate DoD achievability with available sprint capacity
4. Communicate customized DoD to entire team

### **Story Development Integration**
1. Reference DoD when creating story acceptance criteria
2. Use DoD as checklist during story development
3. Validate story completion against DoD before marking done
4. Update DoD based on learnings from story completion

### **Continuous Improvement**
1. Review DoD effectiveness in retrospectives
2. Update DoD based on team maturity and project evolution
3. Benchmark DoD criteria against industry standards
4. Evolve DoD to support team growth and project success 