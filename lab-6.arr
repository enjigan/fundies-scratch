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





