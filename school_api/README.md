# School API

A Rails 8 API-only application modelling a school with students, teachers, departments, courses, semesters, and class sessions.

## Models

| Model | Description |
|---|---|
| `User` | Both students and teachers (`role: "student"` or `"teacher"`) |
| `Department` | English, Math, Science, History, Computer Science |
| `Course` | Belongs to a department |
| `Semester` | Fall 2026 / Spring 2027 |
| `ClassSession` | A course offered in a semester, taught by one teacher |
| `Enrollment` | Join between a student and a class session; stores `grade` |

## Setup

```bash
cd school_api
bundle install
rails db:create db:migrate db:seed
rails server
```

## API Endpoints

### Student routes
| Method | Path | Description |
|---|---|---|
| GET | `/api/v1/students/:id` | Student info |
| GET | `/api/v1/students/:id/courses` | All enrollments with course, semester, teacher, and grade |

### Browse routes (read-only)
| Method | Path | Description |
|---|---|---|
| GET | `/api/v1/departments` | List all departments |
| GET | `/api/v1/departments/:id` | Department + its courses |
| GET | `/api/v1/courses` | List all courses |
| GET | `/api/v1/courses/:id` | Single course |
| GET | `/api/v1/semesters` | List all semesters |
| GET | `/api/v1/semesters/:id` | Single semester |
| GET | `/api/v1/class_sessions` | List all class sessions |
| GET | `/api/v1/class_sessions/:id` | Single class session with students |

## Example requests

```bash
# Get student info (Sam Torres is id 6 after seeding)
curl http://localhost:3000/api/v1/students/6

# Get Sam's courses
curl http://localhost:3000/api/v1/students/6/courses

# List departments
curl http://localhost:3000/api/v1/departments
```
