# db/seeds.rb
# Clears existing data and seeds the school database

puts "Clearing existing data..."
Enrollment.destroy_all
ClassSession.destroy_all
Course.destroy_all
Department.destroy_all
Semester.destroy_all
User.destroy_all

# ── Departments ──────────────────────────────────────────────────────────────
puts "Creating departments..."
english  = Department.create!(name: "English")
math     = Department.create!(name: "Math")
science  = Department.create!(name: "Science")
history  = Department.create!(name: "History")
cs_dept  = Department.create!(name: "Computer Science")

# ── Courses ───────────────────────────────────────────────────────────────────
puts "Creating courses..."
eng101  = Course.create!(name: "English 101",          description: "Introduction to college writing",          department: english)
eng201  = Course.create!(name: "American Literature",  description: "Survey of American literature",            department: english)
math101 = Course.create!(name: "Calculus I",           description: "Limits, derivatives, and integrals",       department: math)
math201 = Course.create!(name: "Linear Algebra",       description: "Vectors, matrices, and linear maps",       department: math)
bio101  = Course.create!(name: "Biology 101",          description: "Fundamentals of biology",                  department: science)
chem101 = Course.create!(name: "Chemistry 101",        description: "Introductory chemistry",                   department: science)
hist101 = Course.create!(name: "World History",        description: "Survey of world history to 1500",          department: history)
hist201 = Course.create!(name: "US History",           description: "United States history from 1776",          department: history)
cs101   = Course.create!(name: "Intro to Programming", description: "Programming fundamentals using Ruby",      department: cs_dept)
cs201   = Course.create!(name: "Data Structures",      description: "Arrays, linked lists, trees, and graphs",  department: cs_dept)

# ── Semesters ─────────────────────────────────────────────────────────────────
puts "Creating semesters..."
fall2026   = Semester.create!(name: "Fall 2026",   start_date: "2026-09-01", end_date: "2026-12-20")
spring2027 = Semester.create!(name: "Spring 2027", start_date: "2027-01-15", end_date: "2027-05-10")

# ── Teachers ──────────────────────────────────────────────────────────────────
puts "Creating teachers..."
teachers = [
  { name: "Dr. Alice Monroe",   email: "alice.monroe@school.edu",   role: "teacher" },
  { name: "Prof. Bob Chen",     email: "bob.chen@school.edu",       role: "teacher" },
  { name: "Dr. Carol Davis",    email: "carol.davis@school.edu",    role: "teacher" },
  { name: "Prof. David Kim",    email: "david.kim@school.edu",      role: "teacher" },
  { name: "Dr. Eva Rosenberg",  email: "eva.rosenberg@school.edu",  role: "teacher" },
].map { |attrs| User.create!(attrs) }

alice, bob, carol, david, eva = teachers

# ── Students ──────────────────────────────────────────────────────────────────
puts "Creating students..."
students = [
  { name: "Sam Torres",     email: "sam.torres@school.edu",     role: "student" },
  { name: "Jamie Lee",      email: "jamie.lee@school.edu",      role: "student" },
  { name: "Morgan Patel",   email: "morgan.patel@school.edu",   role: "student" },
  { name: "Riley Johnson",  email: "riley.johnson@school.edu",  role: "student" },
  { name: "Casey Williams", email: "casey.williams@school.edu", role: "student" },
  { name: "Jordan Smith",   email: "jordan.smith@school.edu",   role: "student" },
  { name: "Taylor Brown",   email: "taylor.brown@school.edu",   role: "student" },
  { name: "Alex Garcia",    email: "alex.garcia@school.edu",    role: "student" },
].map { |attrs| User.create!(attrs) }

sam, jamie, morgan, riley, casey, jordan, taylor, alex = students

# ── Class Sessions ────────────────────────────────────────────────────────────
puts "Creating class sessions..."

# Fall 2026
cs_eng101_f26   = ClassSession.create!(course: eng101,  semester: fall2026,   teacher: alice)
cs_math101_f26  = ClassSession.create!(course: math101, semester: fall2026,   teacher: bob)
cs_bio101_f26   = ClassSession.create!(course: bio101,  semester: fall2026,   teacher: carol)
cs_hist101_f26  = ClassSession.create!(course: hist101, semester: fall2026,   teacher: david)
cs_cs101_f26    = ClassSession.create!(course: cs101,   semester: fall2026,   teacher: eva)

# Spring 2027
cs_eng201_sp27  = ClassSession.create!(course: eng201,  semester: spring2027, teacher: alice)
cs_math201_sp27 = ClassSession.create!(course: math201, semester: spring2027, teacher: bob)
cs_chem101_sp27 = ClassSession.create!(course: chem101, semester: spring2027, teacher: carol)
cs_hist201_sp27 = ClassSession.create!(course: hist201, semester: spring2027, teacher: david)
cs_cs201_sp27   = ClassSession.create!(course: cs201,   semester: spring2027, teacher: eva)

# ── Enrollments (students + grades) ──────────────────────────────────────────
puts "Creating enrollments..."
grades = %w[A A- B+ B B- C+ C]

enrollments = [
  # Sam: heavy CS/Math focus
  { class_session: cs_cs101_f26,    student: sam,    grade: "A"  },
  { class_session: cs_math101_f26,  student: sam,    grade: "B+" },
  { class_session: cs_eng101_f26,   student: sam,    grade: "B"  },
  { class_session: cs_cs201_sp27,   student: sam,    grade: nil  },  # in progress
  { class_session: cs_math201_sp27, student: sam,    grade: nil  },

  # Jamie: English/History focus
  { class_session: cs_eng101_f26,   student: jamie,  grade: "A-" },
  { class_session: cs_hist101_f26,  student: jamie,  grade: "A"  },
  { class_session: cs_eng201_sp27,  student: jamie,  grade: nil  },
  { class_session: cs_hist201_sp27, student: jamie,  grade: nil  },

  # Morgan: Science focus
  { class_session: cs_bio101_f26,   student: morgan, grade: "A"  },
  { class_session: cs_math101_f26,  student: morgan, grade: "A-" },
  { class_session: cs_chem101_sp27, student: morgan, grade: nil  },
  { class_session: cs_math201_sp27, student: morgan, grade: nil  },

  # Riley: mixed
  { class_session: cs_eng101_f26,   student: riley,  grade: "C+" },
  { class_session: cs_cs101_f26,    student: riley,  grade: "B-" },
  { class_session: cs_hist101_f26,  student: riley,  grade: "B"  },
  { class_session: cs_cs201_sp27,   student: riley,  grade: nil  },

  # Casey
  { class_session: cs_bio101_f26,   student: casey,  grade: "B+" },
  { class_session: cs_hist101_f26,  student: casey,  grade: "B"  },
  { class_session: cs_chem101_sp27, student: casey,  grade: nil  },
  { class_session: cs_hist201_sp27, student: casey,  grade: nil  },

  # Jordan
  { class_session: cs_math101_f26,  student: jordan, grade: "A"  },
  { class_session: cs_cs101_f26,    student: jordan, grade: "A-" },
  { class_session: cs_math201_sp27, student: jordan, grade: nil  },
  { class_session: cs_cs201_sp27,   student: jordan, grade: nil  },

  # Taylor
  { class_session: cs_eng101_f26,   student: taylor, grade: "B+" },
  { class_session: cs_bio101_f26,   student: taylor, grade: "B"  },
  { class_session: cs_eng201_sp27,  student: taylor, grade: nil  },
  { class_session: cs_chem101_sp27, student: taylor, grade: nil  },

  # Alex
  { class_session: cs_hist101_f26,  student: alex,   grade: "A-" },
  { class_session: cs_cs101_f26,    student: alex,   grade: "B+" },
  { class_session: cs_hist201_sp27, student: alex,   grade: nil  },
  { class_session: cs_cs201_sp27,   student: alex,   grade: nil  },
]

enrollments.each { |attrs| Enrollment.create!(attrs) }

puts ""
puts "✅  Seed complete!"
puts "   #{Department.count} departments"
puts "   #{Course.count} courses"
puts "   #{Semester.count} semesters"
puts "   #{User.where(role: 'teacher').count} teachers"
puts "   #{User.where(role: 'student').count} students"
puts "   #{ClassSession.count} class sessions"
puts "   #{Enrollment.count} enrollments"
puts ""
puts "Sample student IDs: #{User.where(role: 'student').pluck(:id, :name).map { |id, n| "#{id} (#{n})" }.join(', ')}"
