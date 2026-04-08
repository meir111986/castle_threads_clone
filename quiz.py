import re

input_text = open("input.txt", encoding="utf-8").read()

questions = re.split(r"\n\d+\.\s", input_text)[1:]

result = []

for q in questions:
    lines = q.strip().split("\n")

    question = lines[0].strip("")

    options = {}
    correct = ""

    for line in lines[1:]:
        line = line.strip()

        if re.match(r"[a-d]\)", line):
            key = line[0]  # a, b, c, d
            text = line[3:].strip()
            options[key] = text

        elif "Ответ:" in line:
            correct = line.split("Ответ:")[1].strip()

    formatted_options = []

    for key in ['a', 'b', 'c', 'd']:
        if key in options:
            if key == correct:
                formatted_options.append(
                    f"(+*{key}) {options[key]} \n")  # помечаем
            else:
                formatted_options.append(f"(+{key}) {options[key]} \n")

    full_question = "(+" + question + " " + " ".join(formatted_options)

    result.append(full_question)

with open("quizlet_marked.txt", "w", encoding="utf-8") as f:
    f.write("\n".join(result))

print("Готово: quizlet_marked.txt")
