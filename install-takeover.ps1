# UDO Takeover Installer v1.0.0
# For taking over existing projects with audit-first approach
# PowerShell version for Windows

$ErrorActionPreference = "Stop"
$TAKEOVER_VERSION = "1.1.0"
$REPO_URL = "https://raw.githubusercontent.com/carderel/UDO-take-over-old-project/main"

Write-Host "🔄 UDO TAKEOVER - Project Audit & Orchestration v$TAKEOVER_VERSION" -ForegroundColor Cyan
Write-Host "============================================================"
Write-Host ""
Write-Host "This will:"
Write-Host "  1. Analyze this existing project"
Write-Host "  2. Generate an executive summary for your verification"
Write-Host "  3. Run a comprehensive audit"
Write-Host "  4. Present options for next steps"
Write-Host "  5. Install full UDO orchestration system"
Write-Host ""

# Check if already taken over
if (Test-Path ".takeover") {
    Write-Host "⚠️  This project has already been through takeover." -ForegroundColor Yellow
    Write-Host "   Found: .takeover/"
    Write-Host ""
    Write-Host "Options:"
    Write-Host "  [r] Resume - Continue where you left off"
    Write-Host "  [f] Fresh - Delete takeover data, start over"
    Write-Host "  [c] Cancel"
    Write-Host ""
    $choice = Read-Host "Choice (r/f/c)"
    
    switch ($choice.ToLower()) {
        'r' {
            Write-Host "Resuming takeover process..."
            $RESUME_MODE = $true
        }
        'f' {
            Write-Host "Starting fresh..."
            Remove-Item -Recurse -Force ".takeover"
            $RESUME_MODE = $false
        }
        default {
            Write-Host "Cancelled."
            exit 0
        }
    }
} else {
    $RESUME_MODE = $false
}

# Create takeover structure
Write-Host "📁 Setting up takeover structure..."
New-Item -ItemType Directory -Path ".takeover\audits" -Force | Out-Null
New-Item -ItemType Directory -Path ".takeover\evidence" -Force | Out-Null
New-Item -ItemType Directory -Path ".takeover\agent-templates" -Force | Out-Null

# ============================================================
# TAKEOVER_ORCHESTRATOR.md
# ============================================================
$TAKEOVER_ORCHESTRATOR = @'
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

#### 1.1 Project Structure
- [ ] Total files and folders (excluding .git, node_modules, vendor, etc.)
- [ ] Primary languages/frameworks detected
- [ ] Entry points identified
- [ ] Folder organization pattern

#### 1.2 Documentation Scan
- [ ] README exists? Quality: none/stub/basic/good/excellent
- [ ] Other docs? (docs/, wiki, inline comments)
- [ ] API documentation?

#### 1.3 Existing Tracking
- [ ] Issue tracker? (GitHub issues, TODO.md, etc.)
- [ ] Open issues/TODOs count
- [ ] CHANGELOG exists?

#### 1.4 Dependencies & Environment
- [ ] Package manager (npm, pip, composer, etc.)
- [ ] Dependencies file exists?
- [ ] Can this project likely be run? What's missing?

#### 1.5 Tech Stack Identification
- [ ] Frontend: (React, Vue, vanilla, etc.)
- [ ] Backend: (Node, Python, PHP, etc.)
- [ ] Database: (Postgres, MySQL, MongoDB, etc.)

#### 1.6 Project Type Classification
- [ ] Web Application
- [ ] API/Backend Service
- [ ] Data Pipeline
- [ ] Library/Package
- [ ] Other

#### 1.7 Sensitive Data Scan (DO NOT EXPOSE)
- [ ] Credentials in code? (flag location, don't show content)
- [ ] API keys visible?
- [ ] .env file with secrets?

### Discovery Output
Save to `.takeover/discovery.json`

---

## PHASE 2: EXECUTIVE SUMMARY & VERIFICATION

### Objectives
Present findings to user. Get verification before deep audit.

Create `.takeover/executive-summary.md` with:
- What this project appears to be
- Current state assessment
- Tech stack identified
- Scope estimate
- What couldn't be determined
- Questions for user

**STOP and wait for user verification before proceeding.**

---

## PHASE 3: AUDIT

### Available Audit Agents

#### Always Deploy:
1. **structure-auditor** - Architecture, organization, patterns
2. **documentation-auditor** - Docs quality, gaps, accuracy

#### Deploy Based on Project Type:
- code-quality-auditor
- security-auditor
- test-auditor
- performance-auditor
- dependency-auditor

Each agent writes findings to `.takeover/audits/{agent-name}.md`

---

## PHASE 4: SYNTHESIS

Compile all findings into:

### Audit Report (`.takeover/audit-report.md`)
- Executive summary
- Health scores by category
- Critical / Important / Improvement findings
- What's working well
- Audit limitations

### Options Breakdown (`.takeover/options-breakdown.md`)
- Option A: Quick Wins
- Option B: Stabilization
- Option C: Modernization
- Option D: Rebuild (with justification)

**STOP and wait for user to choose option.**

---

## PHASE 5: TRANSITION TO UDO

### Objectives
Install full UDO system, pre-populated with audit findings, and hand off to ORCHESTRATOR.md

### ⚠️ CRITICAL: This is the only phase where you make changes to the project.

---

### Step 5.1: Confirm User Choice
Before proceeding, confirm:
```
You've chosen Option {X}: {name}

This will:
1. Create a checkpoint of the current project state
2. Install the full UDO orchestration system
3. Convert {N} audit findings into prioritized todos
4. Set up ongoing project management

Proceed? (yes/no)
```

**STOP and wait for explicit "yes" before continuing.**

---

### Step 5.2: Create Pre-Takeover Checkpoint
**Do this FIRST, before any other changes.**

1. Create folder: `.checkpoints/pre-takeover/`
2. Copy project files into it (excluding node_modules, .git, etc.)
3. Create manifest.txt listing what was saved

Tell user: "💾 Pre-takeover checkpoint created. You can restore anytime."

---

### Step 5.3: Install UDO Core Files
Create these files:
- ORCHESTRATOR.md (full UDO instructions)
- START_HERE.md (with takeover context noted)
- PROJECT_STATE.json (with audit findings as todos)
- PROJECT_META.json
- CAPABILITIES.json
- LESSONS_LEARNED.md
- NON_GOALS.md
- OVERSIGHT_DASHBOARD.md

---

### Step 5.4: Create Folder Structure
```
.agents/, .inputs/, .outputs/, .templates/
.project-catalog/ (agents, handoffs, decisions, sessions, errors, archive)
.checkpoints/, .rules/, .memory/ (working, canonical, disposable)
```

---

### Step 5.5: Copy Audit Agents to .agents/
Transform: auditor → specialist (they now do work, not just audit)

---

### Step 5.6: Archive Audit to Project Catalog
Copy audit reports to .project-catalog/decisions/

---

### Step 5.7: Final Handoff Message
```
═══════════════════════════════════════════════════════════════
✅ TAKEOVER COMPLETE
═══════════════════════════════════════════════════════════════

From now on, read ORCHESTRATOR.md for instructions,
NOT TAKEOVER_ORCHESTRATOR.md.

To continue, tell me:
  "Read ORCHESTRATOR.md and resume this project"

To undo everything:
  "Rollback to checkpoint pre-takeover"
═══════════════════════════════════════════════════════════════
```

---

## SAFETY RULES

### Never Do:
- Make changes during audit (read-only until Phase 5)
- Expose sensitive data in reports
- Proceed past verification gates without user confirmation
- Recommend rebuild without strong justification

### Always Do:
- State confidence levels
- Acknowledge what you couldn't determine
- Create pre-takeover checkpoint before changes
- Give user ability to undo everything

---

## COMMANDS

| Command | What It Does |
|---------|--------------|
| `Start takeover` | Begin discovery |
| `Verified` | Confirm understanding, proceed |
| `Correction: {text}` | Update understanding |
| `Start audit` | Deploy audit agents |
| `Audit status` | Show progress |
| `Generate report` | Compile findings |
| `Show options` | Display options |
| `Choose option {A/B/C/D}` | Select path |
| `Install UDO` | Complete transition |
| `Abort takeover` | Stop process |

---

## GETTING STARTED

Say: **"Start takeover"** to begin Phase 1: Discovery.
'@
Set-Content -Path ".takeover\TAKEOVER_ORCHESTRATOR.md" -Value $TAKEOVER_ORCHESTRATOR -Encoding UTF8

# ============================================================
# scope-config.json
# ============================================================
$SCOPE_CONFIG = @'
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
  }
}
'@
Set-Content -Path ".takeover\scope-config.json" -Value $SCOPE_CONFIG -Encoding UTF8

# ============================================================
# discovery.json placeholder
# ============================================================
$DISCOVERY = @'
{
  "status": "pending",
  "timestamp": null,
  "project_name": "",
  "project_type": [],
  "tech_stack": {
    "languages": [],
    "frameworks": [],
    "databases": []
  },
  "documentation": {
    "has_readme": false,
    "readme_quality": "none"
  },
  "environment": {
    "is_runnable": "unknown",
    "runnable_blockers": []
  },
  "scope_estimate": {
    "complexity": "unknown",
    "recommended_audit_depth": "standard"
  },
  "uncertainties": []
}
'@
Set-Content -Path ".takeover\discovery.json" -Value $DISCOVERY -Encoding UTF8

# ============================================================
# Agent templates
# ============================================================
$STRUCTURE_AUDITOR = @'
# Agent: structure-auditor

## Specialization
Project architecture, file organization, and structural patterns analysis.

## What I Look For
- Clear separation of concerns
- Consistent folder naming
- No circular dependencies
- Dead code / orphan files
- Configuration organization

## Audit Output
Write findings to: `.takeover/audits/structure-auditor.md`
'@
Set-Content -Path ".takeover\agent-templates\structure-auditor.md" -Value $STRUCTURE_AUDITOR -Encoding UTF8

$DOCS_AUDITOR = @'
# Agent: documentation-auditor

## Specialization
Documentation quality, completeness, and accuracy assessment.

## What I Look For
- README completeness
- API documentation
- Inline code comments
- Setup instructions
- Up-to-date content

## Audit Output
Write findings to: `.takeover/audits/documentation-auditor.md`
'@
Set-Content -Path ".takeover\agent-templates\documentation-auditor.md" -Value $DOCS_AUDITOR -Encoding UTF8

$CODE_AUDITOR = @'
# Agent: code-quality-auditor

## Specialization
Code standards, patterns, complexity, and maintainability.

## What I Look For
- Consistent formatting
- Code smells (long functions, god classes)
- Deep nesting
- Copy-paste code
- Error handling

## Audit Output
Write findings to: `.takeover/audits/code-quality-auditor.md`
'@
Set-Content -Path ".takeover\agent-templates\code-quality-auditor.md" -Value $CODE_AUDITOR -Encoding UTF8

$SECURITY_AUDITOR = @'
# Agent: security-auditor

## Specialization
Security vulnerabilities and practices.

## ⚠️ CRITICAL: Never expose actual secrets in reports

## What I Look For
- Hardcoded credentials (flag location only)
- Common vulnerabilities (SQL injection, XSS)
- Dependency vulnerabilities
- Authentication/authorization issues

## Audit Output
Write findings to: `.takeover/audits/security-auditor.md`
'@
Set-Content -Path ".takeover\agent-templates\security-auditor.md" -Value $SECURITY_AUDITOR -Encoding UTF8

$TEST_AUDITOR = @'
# Agent: test-auditor

## Specialization
Test coverage, quality, and testing practices.

## What I Look For
- Tests exist and run
- Coverage estimation
- Critical paths tested
- Test quality

## Audit Output
Write findings to: `.takeover/audits/test-auditor.md`
'@
Set-Content -Path ".takeover\agent-templates\test-auditor.md" -Value $TEST_AUDITOR -Encoding UTF8

Write-Host "📋 Takeover structure created."
Write-Host ""
Write-Host "============================================================"
Write-Host ""
Write-Host "✅ UDO Takeover ready!" -ForegroundColor Green
Write-Host ""
Write-Host "Structure created:"
Write-Host "  .takeover/"
Write-Host "    ├── TAKEOVER_ORCHESTRATOR.md  - Instructions for AI"
Write-Host "    ├── discovery.json            - Will hold discovery results"
Write-Host "    ├── scope-config.json         - Audit configuration"
Write-Host "    ├── audits/                   - Audit findings go here"
Write-Host "    ├── evidence/                 - Supporting evidence"
Write-Host "    └── agent-templates/          - Audit agent definitions"
Write-Host ""
Write-Host "Next steps:"
Write-Host "  1. Open your AI chat (Claude, ChatGPT, etc.)"
Write-Host "  2. Say: `"Read .takeover/TAKEOVER_ORCHESTRATOR.md and start takeover`""
Write-Host "  3. AI will scan the project and present findings"
Write-Host "  4. Verify the AI's understanding"
Write-Host "  5. Review audit and choose a path"
Write-Host "  6. Full UDO gets installed with findings as todos"
Write-Host ""
Write-Host "The AI will guide you through each phase."
Write-Host ""
