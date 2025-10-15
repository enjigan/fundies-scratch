use context starter2024
discount_codes = ["NEWYEAR", "student", "NONE", "student", "VIP", "none"]
distinct_codes = list(set(discount_codes))
cleaned_codes = list(map(str.upper, distinct_codes))
unique_cleaned_codes = list(set(cleaned_codes))
responses = ["yes", "NO", "maybe", "Yes", "no", "Maybe"]
lower_responses = list(map(str.lower, responses))
unique_responses = list(set(lower_responses))
definitive_responses = list(filter(lambda x: x != "maybe", unique_responses))
print("Unique Definitive Responses:", definitive_responses)
print("Number of definitive responses:", len(definitive_responses))
