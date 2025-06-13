# Face Check-in Flutter Project - Documentation Index

## 📚 Core Documentation

### **Requirements & Planning**
- **[Project Brief](project-brief.md)** - Project overview and objectives
- **[Product Requirements Document (PRD)](prd.md)** - Detailed requirements and specifications
- **[Frontend Specification](front-end-spec.md)** - UI/UX specifications and guidelines

### **Epic Breakdown**
- **[Epic 1: Project Foundation & Core UI Shell](epic-1.md)** - Technical foundation, BLoC structure, and main UI setup
- **[Epic 2: Real-time Recognition & Feedback](epic-2.md)** - WebSocket communication and recognition feedback system

### **Architecture & Technical Design**  
- **[System Architecture](architecture.md)** - Overall system design and component relationships
- **[Project Structure](project-structure.md)** - Detailed Flutter app directory structure and organization
- **[API Reference](api-reference.md)** - WebSocket communication protocol and message formats
- **[Technology Stack](tech-stack.md)** - Complete list of technologies, libraries, and versions
- **[Operational Guidelines](operational-guidelines.md)** - Coding standards, testing strategy, and error handling
- **[Sequence Diagrams](sequence-diagrams.md)** - Core workflow diagrams for check-in process
- **[Infrastructure & Deployment](infra-deployment.md)** - Deployment strategy and distribution methods
- **[Testing Strategy](testing-strategy.md)** - QA approach and testing protocols
- **[Deployment Guide](deployment-guide.md)** - DevOps processes and environment setup

### **Frontend Documentation**
- **[Frontend Style Guide](front-end-style-guide.md)** - Branding, colors, typography, and design principles
- **[Frontend User Flows](front-end-user-flows.md)** - User experience goals, flows, and navigation structure

### **Project Management**
- **[Stories](stories/)** - User stories and development tasks
  - Current Status: 10 stories across 2 epics (1.x and 2.x series)
  - Epic 1: Authentication & User Management 
  - Epic 2: Face Recognition & Check-in System
- **[Sprints](sprints/)** - Sprint planning and retrospective documentation

## 🎯 **Current Project Status**

### **Story Progress Overview**
- **Epic 1 (Authentication)**: Stories 1.1a, 1.1b, 1.2a, 1.2b, 1.3 
- **Epic 2 (Face Recognition)**: Stories 2.1a, 2.1b, 2.2a, 2.2b, 2.3

### **Technology Stack**
- **Framework**: Flutter/Dart
- **Architecture**: Clean Architecture with BLoC pattern
- **DI**: GetIt/Injectable
- **Navigation**: GoRouter
- **HTTP**: Dio/Retrofit
- **Real-time**: WebSocket (web_socket_channel)
- **Camera**: Camera plugin for image capture
- **Image Processing**: Real-time image transmission to backend

### **Key Components**
- **Authentication System**: User login/registration with secure token management
- **Face Recognition Pipeline**: Camera capture → Image processing → Backend AI analysis
- **Check-in System**: Face verification for attendance tracking
- **Real-time Communication**: WebSocket streaming for live face recognition
- **Backend Integration**: REST APIs and WebSocket connections

## 📋 **Story Creation Guidelines**

### **Epic Structure**
- **Epic 1**: Authentication & User Management System
- **Epic 2**: Face Recognition & Check-in Functionality  
- **Epic 3**: (Future) Advanced Features & Analytics

### **Story Naming Convention**
- Format: `{EpicNum}.{StoryNum}{SubComponent}.story.md`
- Example: `1.1a.story.md`, `2.3.story.md`
- Sub-components (a/b) used for parallel development splitting

### **Technical Context Integration**
- Stories reference architecture patterns from `architecture.md`
- UI stories follow specifications in `front-end-spec.md`
- Testing approaches align with `testing-strategy.md`
- Deployment considerations from `deployment-guide.md`

## 🔧 **Development Workflow**

### **Story Development Process**
1. **Story Preparation**: Technical Scrum Master creates story with full context
2. **Development**: Flutter Dev (David) implements with Clean Architecture
3. **Testing**: Following testing strategy and Definition of Done
4. **Integration**: Deploy using deployment guide procedures

### **Quality Standards**
- **Code Coverage**: ≥85% for all new features
- **Performance**: App load ≤3s, API response ≤500ms  
- **Compatibility**: iOS 15+, Android 10+
- **Face Recognition Accuracy**: ≥99% in controlled conditions

### **Sprint Planning Integration**
- Sprint capacity based on story points and team velocity
- Parallel development opportunities with .a/.b story splitting
- Integration points scheduled for face recognition pipeline
- Technical debt allocation: 15-20% per sprint 