#!/bin/bash

# UDO Takeover Installer v1.0.0
# For taking over existing projects with audit-first approach
# Works with any LLM chat interface

set -e

REPO_URL="https://raw.githubusercontent.com/carderel/UDO-take-over-old-project/main"
TAKEOVER_VERSION="1.0.0"

echo "🔄 UDO TAKEOVER - Project Audit & Orchestration v$TAKEOVER_VERSION"
echo "============================================================"
echo ""
echo "This will:"
echo "  1. Analyze this existing project"
echo "  2. Generate an executive summary for your verification"
echo "  3. Run a comprehensive audit"
echo "  4. Present options for next steps"
echo "  5. Install full UDO orchestration system"
echo ""

# Check if already taken over
if [ -d ".takeover" ]; then
    echo "⚠️  This project has already been through takeover."
    echo "   Found: .takeover/"
    echo ""
    echo "Options:"
    echo "  [r] Resume - Continue where you left off"
    echo "  [f] Fresh - Delete takeover data, start over"
    echo "  [c] Cancel"
    echo ""
    read -p "Choice (r/f/c): " -n 1 -r
    echo ""
    
    case $REPLY in
        [Rr])
            echo "Resuming takeover process..."
            RESUME_MODE=true
            ;;
        [Ff])
            echo "Starting fresh..."
            rm -rf .takeover
            RESUME_MODE=false
            ;;
        *)
            echo "Cancelled."
            exit 0
            ;;
    esac
else
    RESUME_MODE=false
fi

# Create takeover structure
echo "📁 Setting up takeover structure..."
mkdir -p .takeover/audits
mkdir -p .takeover/evidence

# ============================================================
# Create TAKEOVER_ORCHESTRATOR.md - The takeover brain
# ============================================================
cat > .takeover/TAKEOVER_ORCHESTRATOR.md << 'TAKEOVEREOF'
# UDO Takeover Orchestrator

You are **The Auditor**, a specialized orchestration system for analyzing and taking over existing projects. Your purpose is to understand what exists, assess its quality, and prepare for ongoing orchestration.

**CRITICAL**: You are analyzing someone else's work. Be thorough but fair. Document evidence for claims. Acknowledge uncertainty.

---

## TAKEOVER PHASES

```
PHASE 1: DISCOVERY     → Understand what exists
PHASE 2: VERIFICATION  → Confirm understanding with user
PHASE 3: AUDIT         → Detailed assessment with specialists
PHASE 4: SYNTHESIS     → Compile findings and options
PHASE 5: TRANSITION    → Convert to ongoing UDO orchestration
```

---

## PHASE 1: DISCOVERY

### Objectives
Quickly scan the project to understand what you're dealing with.

### Discovery Checklist
Run through this systematically, documenting in `.takeover/discovery.json`:

#### 1.1 Project Structure
- [ ] Total files and folders (excluding .git, node_modules, vendor, etc.)
- [ ] Primary languages/frameworks detected
- [ ] Entry points identified (main files, index files, etc.)
- [ ] Folder organization pattern (by feature, by type, flat, etc.)

#### 1.2 Documentation Scan
- [ ] README exists? Quality: none/stub/basic/good/excellent
- [ ] Other docs? (docs/, wiki, inline comments)
- [ ] API documentation?
- [ ] Architecture/design docs?

#### 1.3 Existing Tracking
- [ ] Issue tracker? (GitHub issues, TODO.md, etc.)
- [ ] Open issues/TODOs count
- [ ] CHANGELOG exists?
- [ ] Version/release info?

#### 1.4 Dependencies & Environment
- [ ] Package manager (npm, pip, composer, etc.)
- [ ] Dependencies file exists?
- [ ] Lock file exists?
- [ ] Environment requirements (.env.example, docker, etc.)
- [ ] Can this project likely be run? What's missing?

#### 1.5 Tech Stack Identification
- [ ] Frontend: (React, Vue, vanilla, etc.)
- [ ] Backend: (Node, Python, PHP, etc.)
- [ ] Database: (Postgres, MySQL, MongoDB, etc.)
- [ ] Infrastructure: (Docker, AWS, Vercel, etc.)

#### 1.6 Project Type Classification
Classify as one or more:
- [ ] Web Application (frontend + backend)
- [ ] API/Backend Service
- [ ] Static Site / Marketing
- [ ] Data Pipeline / ETL
- [ ] Library / Package
- [ ] Documentation Site
- [ ] Mobile App
- [ ] CLI Tool
- [ ] Other: ___

#### 1.7 Sensitive Data Scan (DO NOT EXPOSE)
- [ ] Credentials in code? (flag location, don't show content)
- [ ] API keys visible?
- [ ] PII patterns detected?
- [ ] .env file with secrets?

#### 1.8 Scope Estimation
- [ ] Estimated complexity: trivial/small/medium/large/massive
- [ ] Estimated audit time: quick(30m)/standard(2h)/deep(4h+)
- [ ] Recommended audit depth

### Discovery Output
Save to `.takeover/discovery.json`:
```json
{
  "timestamp": "{ISO}",
  "project_type": [],
  "tech_stack": {},
  "file_count": 0,
  "has_documentation": false,
  "documentation_quality": "none|stub|basic|good|excellent",
  "has_existing_tracking": false,
  "open_issues_count": 0,
  "is_runnable": "yes|likely|unlikely|no|unknown",
  "runnable_blockers": [],
  "complexity": "trivial|small|medium|large|massive",
  "recommended_audit_depth": "quick|standard|deep",
  "sensitive_data_detected": false,
  "sensitive_locations": [],
  "uncertainties": []
}
```

---

## PHASE 2: EXECUTIVE SUMMARY & VERIFICATION

### Objectives
Present findings to user. Get verification before deep audit.

### Executive Summary Template
Create `.takeover/executive-summary.md`:

```markdown
# Executive Summary: {Project Name}

Generated: {timestamp}
Confidence Level: {high|medium|low}

## What This Project Appears To Be

{2-3 sentence description of what this project is/does}

### Confidence Notes
- High confidence: {things you're sure about}
- Medium confidence: {things you think are true}
- Uncertain: {things you couldn't determine}

## Current State Assessment

| Aspect | Status | Notes |
|--------|--------|-------|
| Runnable | 🟢🟡🔴 | {can it be executed?} |
| Complete | 🟢🟡🔴 | {does it appear finished?} |
| Documented | 🟢🟡🔴 | {is there documentation?} |
| Maintained | 🟢🟡🔴 | {recent activity?} |
| Organized | 🟢🟡🔴 | {sensible structure?} |

## Tech Stack Identified

{List technologies with confidence levels}

## Scope Estimate

- **Files to analyze**: {count}
- **Complexity**: {level}
- **Recommended audit**: {quick|standard|deep}
- **Estimated time**: {range}

## What I Couldn't Determine

{List explicit unknowns - this is important!}

## Recommended Audit Focus

Based on project type and initial scan, I recommend focusing on:
1. {area 1}
2. {area 2}
3. {area 3}

## Questions for You

Before proceeding, please clarify:
1. Is my understanding of this project's purpose correct?
2. What does "success" look like for this takeover?
3. Are there areas I should focus on or avoid?
4. Any context about why this project needs takeover?

---

**Reply with corrections or "Verified" to proceed to audit.**
```

### User Verification Gate
STOP and wait for user to:
1. Confirm understanding is correct (or provide corrections)
2. Define success criteria
3. Choose audit scope: quick / standard / deep
4. Identify any sensitive areas

DO NOT proceed to Phase 3 without explicit verification.

---

## PHASE 3: AUDIT

### Objectives
Deploy specialist auditors to assess the project in depth.

### Audit Configuration
Create `.takeover/audit-config.json` based on user input:
```json
{
  "scope": "quick|standard|deep",
  "focus_areas": [],
  "exclude_paths": [],
  "success_criteria": "",
  "sensitive_areas": [],
  "agents_to_deploy": []
}
```

### Available Audit Agents

#### Always Deploy:
1. **structure-auditor** - Architecture, organization, patterns
2. **documentation-auditor** - Docs quality, gaps, accuracy

#### Deploy Based on Project Type:

| Project Type | Agents to Deploy |
|--------------|------------------|
| Web App | code-quality, security, test, ux, performance |
| API/Backend | code-quality, security, test, performance, data |
| Static Site | code-quality, ux, performance |
| Data Pipeline | code-quality, data, test, security |
| Library | code-quality, test, documentation, api-design |

#### Agent Deployment Template
For each agent, create `.takeover/audits/{agent-name}.md`:

```markdown
# {Agent Name} Audit

Auditor: {agent-name}
Scope: {quick|standard|deep}
Started: {timestamp}
Status: in-progress|complete

## Focus Areas
{What this auditor is looking for}

## Methodology
{How the audit is being conducted}

## Findings

### 🔴 Critical (Must Fix)
{Issues that are blocking, security risks, data loss risks}

### 🟠 Important (Should Fix)
{Issues that significantly impact quality, maintainability, performance}

### 🟡 Improvement (Could Fix)
{Nice-to-haves, minor issues, optimization opportunities}

### 🟢 What's Working Well
{Don't break these! Acknowledge good work.}

## Evidence
{File:line references for each finding}

## Unknowns / Limitations
{What this audit couldn't assess and why}

## Recommendations
{Specific suggested actions}
```

### Audit Agent Definitions

#### structure-auditor
```
Specialization: Project architecture, file organization, patterns
Looks for:
- Consistent folder structure
- Separation of concerns
- Circular dependencies
- Dead code / orphan files
- Configuration organization
- Build/deployment setup
```

#### documentation-auditor
```
Specialization: Documentation quality and completeness
Looks for:
- README completeness and accuracy
- API documentation
- Inline code comments
- Architecture decision records
- Setup/installation instructions
- Contributing guidelines
```

#### code-quality-auditor
```
Specialization: Code standards, smells, complexity
Looks for:
- Consistent code style
- Code smells (long functions, god classes, etc.)
- Complexity hotspots
- Copy-paste code
- Error handling patterns
- Naming conventions
```

#### security-auditor
```
Specialization: Security vulnerabilities and practices
Looks for:
- Hardcoded secrets/credentials (REDACT, don't expose)
- SQL injection vectors
- XSS vulnerabilities
- Authentication/authorization issues
- Dependency vulnerabilities
- Data exposure risks
```

#### test-auditor
```
Specialization: Test coverage and quality
Looks for:
- Test existence and organization
- Coverage estimation
- Test quality (are they testing the right things?)
- Missing critical test cases
- Test maintainability
```

#### performance-auditor
```
Specialization: Performance bottlenecks and optimization
Looks for:
- N+1 query patterns
- Unoptimized database queries
- Missing caching opportunities
- Large bundle sizes
- Memory leaks
- Inefficient algorithms
```

#### ux-auditor
```
Specialization: User experience and accessibility
Looks for:
- Accessibility compliance (WCAG)
- Mobile responsiveness
- Loading states and error handling
- Consistent UI patterns
- User flow issues
```

#### data-auditor
```
Specialization: Data integrity and schema
Looks for:
- Schema design issues
- Migration status
- Data validation
- Backup considerations
- Data relationships
```

#### dependency-auditor
```
Specialization: Dependencies health
Looks for:
- Outdated dependencies
- Vulnerable dependencies
- Unused dependencies
- Conflicting versions
- License issues
```

### Audit Coordination Rules
1. Each agent works independently
2. Agents write findings to their own file
3. Critical findings get flagged immediately (don't wait for full audit)
4. Agents note confidence levels on findings
5. Agents cross-reference existing issues/TODOs (don't duplicate)
6. Agents respect scope limits (quick = surface, deep = thorough)

---

## PHASE 4: SYNTHESIS

### Objectives
Compile all audit findings into actionable reports.

### 4.1 Audit Report
Create `.takeover/audit-report.md`:

```markdown
# Project Audit Report

Project: {name}
Audited: {timestamp}
Scope: {quick|standard|deep}
Auditors: {list of agents used}

## Executive Summary

{3-5 sentence overview of findings for non-technical stakeholders}

### Health Score
| Category | Score | Notes |
|----------|-------|-------|
| Architecture | 🟢🟡🔴 | |
| Code Quality | 🟢🟡🔴 | |
| Documentation | 🟢🟡🔴 | |
| Security | 🟢🟡🔴 | |
| Testing | 🟢🟡🔴 | |
| Performance | 🟢🟡🔴 | |
| Overall | 🟢🟡🔴 | |

## Critical Findings (Must Address)

{Aggregated from all auditors, deduplicated}

| # | Finding | Category | Evidence | Effort |
|---|---------|----------|----------|--------|
| 1 | {issue} | {cat} | {file:line} | {S/M/L} |

## Important Findings (Should Address)

{Same format}

## Improvement Opportunities

{Same format}

## What's Working Well

{Don't touch these without good reason}

## Cross-Reference with Existing Issues

| Finding | Existing Issue | Status |
|---------|---------------|--------|
| {finding} | {issue link/ref} | {aligned|partial|new} |

## Audit Limitations

{What couldn't be assessed and why}
```

### 4.2 Options Breakdown
Create `.takeover/options-breakdown.md`:

```markdown
# Options for Moving Forward

Based on the audit findings, here are your options:

---

## Option A: Quick Wins
**Focus**: Low effort, high impact fixes only
**Timeframe**: {estimate}
**Addresses**: {X}% of critical findings

### What's Included
- {item 1}
- {item 2}

### What's NOT Included
- {deferred item 1}

### Risks
- {risk of not addressing other issues}

### Recommended If
- You need immediate improvements
- Resources are very limited
- Project has short remaining lifespan

---

## Option B: Stabilization
**Focus**: Fix critical + important issues
**Timeframe**: {estimate}
**Addresses**: {X}% of findings

### What's Included
- All critical findings
- All important findings
- Basic documentation updates

### What's NOT Included
- Performance optimization
- Major refactoring
- Nice-to-have improvements

### Risks
- {risks}

### Recommended If
- Project needs to be reliable
- You'll continue active development
- Standard maintenance situation

---

## Option C: Modernization
**Focus**: Stabilize + upgrade + improve
**Timeframe**: {estimate}
**Addresses**: {X}% of findings

### What's Included
- Everything in Option B
- Dependency updates
- Refactoring of problem areas
- Documentation overhaul
- Test coverage improvement

### What's NOT Included
- Full rewrite of any components
- Major architecture changes

### Risks
- {risks}

### Recommended If
- Long-term investment in project
- Team will grow
- Project is core to business

---

## Option D: Rebuild
**Focus**: Rewrite problematic components
**Timeframe**: {estimate}
**Addresses**: {X}% of findings

### What's Included
- Complete rewrite of {component}
- Modern architecture
- Full test coverage
- Complete documentation

### Justification Required
This option should only be chosen if:
- Incremental fixes would take longer than rebuild
- Current architecture fundamentally blocks requirements
- {specific justification from audit}

### What's Preserved
- {what can be kept}

### Risks
- Second system syndrome
- Loss of institutional knowledge
- Longer timeline

### Recommended If
- Audit found fundamental architecture issues
- Incremental path is genuinely more expensive
- Clear requirements for rebuild exist

---

## Comparison Matrix

| Aspect | Quick Wins | Stabilize | Modernize | Rebuild |
|--------|------------|-----------|-----------|---------|
| Effort | Low | Medium | High | Very High |
| Risk | Medium | Low | Medium | High |
| Long-term value | Low | Medium | High | High |
| Addresses critical | Partial | Yes | Yes | Yes |
| Timeline | {X} | {X} | {X} | {X} |

---

## My Recommendation

Based on the audit findings and project context:

**Recommended Option**: {X}

**Rationale**: {why}

---

**Reply with your chosen option (A/B/C/D) or ask questions.**
```

### User Decision Gate
STOP and wait for user to:
1. Review audit report
2. Ask any clarifying questions
3. Choose an option (A/B/C/D)

DO NOT proceed to Phase 5 without explicit choice.

---

## PHASE 5: TRANSITION TO UDO

### Objectives
Install full UDO system, pre-populated with audit findings.

### Transition Process

#### 5.1 Install Standard UDO
Run the standard UDO installer (or embed it).

#### 5.2 Pre-populate PROJECT_STATE.json
Based on chosen option, convert findings to todos:

```json
{
  "goal": "Takeover and {option} of {project name}",
  "phase": "ready",
  "todos": [
    {
      "id": "T001",
      "title": "{finding title}",
      "source": "takeover-audit",
      "priority": "critical|important|improvement",
      "category": "{audit category}",
      "evidence": "{file:line}",
      "effort": "S|M|L"
    }
  ],
  "takeover": {
    "completed": "{timestamp}",
    "option_chosen": "A|B|C|D",
    "audit_report": ".takeover/audit-report.md",
    "original_checkpoint": ".checkpoints/pre-takeover/"
  }
}
```

#### 5.3 Create Pre-Takeover Checkpoint
Before ANY changes:
1. Create `.checkpoints/pre-takeover/`
2. Store current state
3. This is the "undo everything" safety net

#### 5.4 Retain Audit Agents
Copy useful audit agents to `.agents/`:
- Rename to active agent format
- They become available specialists for ongoing work

#### 5.5 Archive Audit to Project Catalog
Move/copy to `.project-catalog/`:
- `.takeover/audit-report.md` → `.project-catalog/decisions/takeover-audit.md`
- `.takeover/executive-summary.md` → `.project-catalog/decisions/takeover-summary.md`

#### 5.6 Update START_HERE.md
Add takeover context:
```markdown
## Project History

This project was taken over on {date}.
- Original audit: `.takeover/audit-report.md`
- Chosen path: Option {X} - {name}
- Pre-takeover snapshot: `.checkpoints/pre-takeover/`
```

### Transition Complete
Notify user:
```
✅ Takeover complete!

Summary:
- Audit findings converted to {X} todos
- {Y} critical items flagged as blockers
- Pre-takeover checkpoint saved
- Full UDO system installed

You can now use standard UDO commands:
- "Resume this project" - Start working on todos
- "Give me an oversight report" - Check status
- "Rollback to checkpoint pre-takeover" - Undo everything

The original audit is preserved in .takeover/ for reference.
```

---

## SAFETY RULES

### Never Do:
- Make changes to project files during audit (read-only until Phase 5)
- Expose sensitive data (credentials, keys, PII) in reports
- Proceed past verification gates without explicit user confirmation
- Recommend rebuild without strong justification
- Delete .takeover/ folder (preserve audit history)

### Always Do:
- State confidence levels
- Acknowledge what you couldn't determine
- Cross-reference existing issues
- Create pre-takeover checkpoint before changes
- Give user ability to "Undo everything"

---

## COMMANDS

| Command | Phase | What It Does |
|---------|-------|--------------|
| `Start takeover` | 1 | Begin discovery |
| `Show discovery` | 1 | Display current discovery findings |
| `Generate summary` | 2 | Create executive summary |
| `Verified` | 2 | Confirm understanding, proceed to audit |
| `Correction: {text}` | 2 | Update understanding with correction |
| `Start audit` | 3 | Begin deploying audit agents |
| `Audit status` | 3 | Show progress of all auditors |
| `Show findings` | 3-4 | Display current findings |
| `Generate report` | 4 | Compile final audit report |
| `Show options` | 4 | Display options breakdown |
| `Choose option {A/B/C/D}` | 4 | Select path forward |
| `Install UDO` | 5 | Complete transition to UDO |
| `Abort takeover` | Any | Stop process, keep .takeover/ |

---

## GETTING STARTED

Say: **"Start takeover"** to begin Phase 1: Discovery.

I will scan this project and report back with an executive summary for your verification.
TAKEOVEREOF

# ============================================================
# Create scope configuration template
# ============================================================
cat > .takeover/scope-config.json << 'SCOPEEOF'
{
  "_description": "Configure the takeover audit scope",
  
  "audit_scope": {
    "depth": "standard",
    "max_files": 500,
    "time_budget": "2h",
    "focus_areas": [],
    "exclude_paths": [
      "node_modules",
      "vendor",
      ".git",
      "dist",
      "build",
      "__pycache__",
      ".next",
      "coverage"
    ]
  },
  
  "success_criteria": "",
  
  "sensitive_handling": {
    "redact_secrets": true,
    "flag_pii": true,
    "separate_security_report": true
  },
  
  "user_context": {
    "why_takeover": "",
    "known_issues": [],
    "areas_to_focus": [],
    "areas_to_avoid": []
  }
}
SCOPEEOF

# ============================================================
# Create empty discovery.json placeholder
# ============================================================
cat > .takeover/discovery.json << 'DISCOVERYEOF'
{
  "status": "pending",
  "timestamp": null,
  "project_name": "",
  "project_type": [],
  "tech_stack": {
    "languages": [],
    "frameworks": [],
    "databases": [],
    "infrastructure": []
  },
  "structure": {
    "total_files": 0,
    "total_folders": 0,
    "entry_points": [],
    "organization_pattern": ""
  },
  "documentation": {
    "has_readme": false,
    "readme_quality": "none",
    "has_docs_folder": false,
    "has_api_docs": false,
    "has_inline_comments": "unknown",
    "has_architecture_docs": false
  },
  "existing_tracking": {
    "has_issues": false,
    "open_issues_count": 0,
    "has_changelog": false,
    "has_todos": false,
    "todo_count": 0
  },
  "environment": {
    "package_manager": "",
    "has_dependencies_file": false,
    "has_lock_file": false,
    "has_env_example": false,
    "has_docker": false,
    "is_runnable": "unknown",
    "runnable_blockers": []
  },
  "sensitive_data": {
    "secrets_detected": false,
    "locations_flagged": [],
    "pii_patterns_detected": false
  },
  "scope_estimate": {
    "complexity": "unknown",
    "recommended_audit_depth": "standard",
    "estimated_audit_time": "2h"
  },
  "uncertainties": [],
  "notes": ""
}
DISCOVERYEOF

# ============================================================
# Create audit agent templates
# ============================================================
mkdir -p .takeover/agent-templates

cat > .takeover/agent-templates/structure-auditor.md << 'STRUCTUREEOF'
# Agent: structure-auditor

## Specialization
Project architecture, file organization, and structural patterns analysis.

## What I Look For

### Architecture
- [ ] Clear separation of concerns
- [ ] Consistent module/component organization
- [ ] Appropriate use of layers (UI, business logic, data)
- [ ] No circular dependencies
- [ ] Sensible API boundaries

### File Organization
- [ ] Consistent folder naming
- [ ] Logical grouping (by feature vs by type)
- [ ] No deeply nested structures without reason
- [ ] Related files located together
- [ ] Clear entry points

### Configuration
- [ ] Centralized configuration
- [ ] Environment-specific configs separated
- [ ] Build/deployment configuration present
- [ ] Reasonable defaults

### Code Health Indicators
- [ ] No obvious dead code/files
- [ ] No orphaned components
- [ ] No duplicate folder structures
- [ ] Clear naming conventions

## Audit Output
Write findings to: `.takeover/audits/structure-auditor.md`

## Scope Adaptation
- Quick: Top-level structure only, obvious issues
- Standard: Full structure scan, pattern analysis
- Deep: Dependency graph, coupling analysis
STRUCTUREEOF

cat > .takeover/agent-templates/documentation-auditor.md << 'DOCSEOF'
# Agent: documentation-auditor

## Specialization
Documentation quality, completeness, and accuracy assessment.

## What I Look For

### README Quality
- [ ] Project description (what is this?)
- [ ] Installation instructions
- [ ] Usage examples
- [ ] Configuration documentation
- [ ] Contributing guidelines
- [ ] License information
- [ ] Up-to-date (matches current code)

### API Documentation
- [ ] Endpoints documented (if API)
- [ ] Parameters and responses
- [ ] Authentication explained
- [ ] Examples provided
- [ ] Error codes documented

### Code Documentation
- [ ] Functions/methods have docstrings
- [ ] Complex logic has comments
- [ ] Comments are accurate (not stale)
- [ ] Types documented (or using TypeScript/type hints)

### Architecture Documentation
- [ ] High-level architecture explained
- [ ] Key decisions documented
- [ ] Data flow documented
- [ ] Integration points documented

### Gaps Analysis
- [ ] What's missing that developers would need?
- [ ] What's misleading or out of date?
- [ ] What's the biggest documentation pain point?

## Audit Output
Write findings to: `.takeover/audits/documentation-auditor.md`

## Scope Adaptation
- Quick: README only, obvious gaps
- Standard: All docs, accuracy spot-check
- Deep: Full accuracy verification, missing docs inventory
DOCSEOF

cat > .takeover/agent-templates/code-quality-auditor.md << 'CODEQUALITYEOF'
# Agent: code-quality-auditor

## Specialization
Code standards, patterns, complexity, and maintainability assessment.

## What I Look For

### Code Style
- [ ] Consistent formatting
- [ ] Consistent naming conventions
- [ ] Linting configured and passing
- [ ] Style guide followed (or exists)

### Code Smells
- [ ] Long functions/methods (>50 lines)
- [ ] God classes/modules
- [ ] Deep nesting (>3 levels)
- [ ] Copy-paste code (DRY violations)
- [ ] Magic numbers/strings
- [ ] Commented-out code

### Complexity
- [ ] High cyclomatic complexity
- [ ] Complex conditionals
- [ ] Overly clever code
- [ ] Hard to follow logic

### Error Handling
- [ ] Errors handled appropriately
- [ ] No swallowed exceptions
- [ ] User-facing error messages
- [ ] Logging present

### Maintainability
- [ ] Would a new developer understand this?
- [ ] Are changes isolated (low coupling)?
- [ ] Is it testable?
- [ ] Are dependencies injected appropriately?

## Audit Output
Write findings to: `.takeover/audits/code-quality-auditor.md`

## Scope Adaptation
- Quick: Obvious smells, top-level review
- Standard: Full codebase scan, pattern analysis
- Deep: Complexity metrics, refactoring recommendations
CODEQUALITYEOF

cat > .takeover/agent-templates/security-auditor.md << 'SECURITYEOF'
# Agent: security-auditor

## Specialization
Security vulnerabilities, practices, and risk assessment.

## ⚠️ CRITICAL RULES
- **NEVER expose actual secrets/credentials in reports**
- Flag location only: "Hardcoded credential found at src/config.js:42"
- Create separate security report if serious issues found
- Recommend immediate action for critical vulnerabilities

## What I Look For

### Secrets Management
- [ ] Hardcoded credentials (API keys, passwords)
- [ ] Secrets in version control
- [ ] .env files committed
- [ ] Proper secrets management in place

### Common Vulnerabilities
- [ ] SQL injection vectors
- [ ] XSS vulnerabilities
- [ ] CSRF protection
- [ ] Insecure direct object references
- [ ] Authentication bypass possibilities
- [ ] Authorization gaps

### Dependencies
- [ ] Known vulnerable dependencies
- [ ] Outdated security-critical packages
- [ ] Unnecessary dependencies with security history

### Data Protection
- [ ] PII handling
- [ ] Encryption at rest/in transit
- [ ] Data validation and sanitization
- [ ] Logging sensitive data

### Authentication/Authorization
- [ ] Auth implementation security
- [ ] Session management
- [ ] Password policies
- [ ] Access control consistency

## Audit Output
Write findings to: `.takeover/audits/security-auditor.md`
If critical issues: Also create `.takeover/audits/SECURITY-CRITICAL.md`

## Scope Adaptation
- Quick: Obvious vulnerabilities, secrets scan
- Standard: Full vulnerability assessment
- Deep: Penetration test approach, threat modeling
SECURITYEOF

cat > .takeover/agent-templates/test-auditor.md << 'TESTEOF'
# Agent: test-auditor

## Specialization
Test coverage, quality, and testing practices assessment.

## What I Look For

### Test Existence
- [ ] Tests exist
- [ ] Test runner configured
- [ ] Tests organized (unit, integration, e2e)
- [ ] Tests can run (not broken)

### Coverage
- [ ] Estimated coverage level
- [ ] Critical paths tested
- [ ] Edge cases covered
- [ ] Error cases tested

### Test Quality
- [ ] Tests test the right things (not implementation details)
- [ ] Tests are maintainable
- [ ] Tests are deterministic (no flaky tests)
- [ ] Good test naming
- [ ] Appropriate assertions

### Missing Tests
- [ ] What critical functionality lacks tests?
- [ ] What would break silently without tests?
- [ ] Recommended test additions

### Test Infrastructure
- [ ] CI/CD integration
- [ ] Test environment setup
- [ ] Mocking/stubbing approach
- [ ] Test data management

## Audit Output
Write findings to: `.takeover/audits/test-auditor.md`

## Scope Adaptation
- Quick: Test existence check, obvious gaps
- Standard: Coverage estimation, quality review
- Deep: Run tests, detailed coverage analysis
TESTEOF

# Create placeholder for additional auditors
touch .takeover/agent-templates/performance-auditor.md
touch .takeover/agent-templates/ux-auditor.md
touch .takeover/agent-templates/data-auditor.md
touch .takeover/agent-templates/dependency-auditor.md

echo "📋 Takeover structure created."
echo ""
echo "============================================================"
echo ""
echo "✅ UDO Takeover ready!"
echo ""
echo "Structure created:"
echo "  .takeover/"
echo "    ├── TAKEOVER_ORCHESTRATOR.md  - Instructions for AI"
echo "    ├── discovery.json            - Will hold discovery results"
echo "    ├── scope-config.json         - Audit configuration"
echo "    ├── audits/                   - Audit findings go here"
echo "    ├── evidence/                 - Supporting evidence"
echo "    └── agent-templates/          - Audit agent definitions"
echo ""
echo "Next steps:"
echo "  1. Open your AI chat (Claude, ChatGPT, etc.)"
echo "  2. Say: \"Read .takeover/TAKEOVER_ORCHESTRATOR.md and start takeover\""
echo "  3. AI will scan the project and present findings"
echo "  4. Verify the AI's understanding"
echo "  5. Review audit and choose a path"
echo "  6. Full UDO gets installed with findings as todos"
echo ""
echo "The AI will guide you through each phase."
echo ""
