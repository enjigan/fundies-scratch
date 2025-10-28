use context dcic2024
include csv
include data-source
include lists

student_score = load-table: 
  Name :: String, 
  Surname :: String, 
  Email :: String, 
  Score :: Number
  source: csv-table-file("students_gate_exam_score.csv", default-options) 

sanitize Score using num-sanitizer
end

# Order the table by Score in descending order
ordered_scores = student_score.order-by("Score", false)

# Extract the top 3 rows
first = ordered_scores.row-n(0)
second = ordered_scores.row-n(1)
third = ordered_scores.row-n(2)

# Create a list of small records (Name, Surname, Score)
top3 = link(
    {Name: first["Name"], Surname: first["Surname"], Score: first["Score"]},
    link(
      {Name: second["Name"], Surname: second["Surname"], Score: second["Score"]},
      link(
        {Name: third["Name"], Surname: third["Surname"], Score: third["Score"]},
        empty)))

# Define a structured Data type for the student
data Student:
  | student(name :: String, surname :: String, score :: Number)
end

# Replace the names and scores with your actual top 3 students
s1 = student(first["Name"], first["Surname"], first["Score"])
s2 = student(second["Name"], second["Surname"], second["Score"])
s3 = student(third["Name"], third["Surname"], third["Score"])

# Recursive function: Count student with scores > 90
scores = link(
  s1.score,
  link(
    s2.score,
    link(
      s3.score,
      empty
    )
  )
)

fun countAbove90(lst :: List<Number>) -> Number:
  cases (List) lst:
    | empty => 0
    | link(first1, rest) =>
      if first1 > 90:
          1 + countAbove90(rest)
        else:
          countAbove90(rest)
  end
 end
end

# Recursive function to return Students with score > 80
top_3 = link(s1, link(s2, link(s3, empty)))

# Recursive function to filter students with score > 80
fun studentsAbove80(lst :: List<Student>) -> List<Student>:
  cases (List) lst:
    | empty => empty
    | link(first2, rest) =>
      if first2.score > 80:
        link(first2, studentsAbove80(rest))
        else:
          studentsAbove80(rest)
  end
 end
end


