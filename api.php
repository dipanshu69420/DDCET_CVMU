<?php

// Add the new question data
$newQuestion = [
    "id" => 44,
    "question" => "Equation of a line which passes through (1!-2) and cuts off equal intercepts on the axes is ---",
    "A" => "x!y = 1",
    "B" => "x^y = 1",
    "C" => "x + y = -1",
    "D" => "x - y = -1",
    "ANS" => "C",
    "justification" => "Equation is x!y = a^b. It passes through (1,-2) so a = -1",
    "category" => 1
];

$questions[] = $newQuestion;

// Replace "!" with "<sub>!</sub>" in each question
$modifiedQuestions = array_map(function($question) {
    // Replace "!" with "<sub>!</sub>"
    $question['question'] = preg_replace('/!(.+)/', '<sub>$1</sub>', $question['question']);
    $question['A'] = preg_replace('/!(.+)/', '<sub>$1</sub>', $question['A']);
    $question['B'] = preg_replace('/!(.+)/', '<sub>$1</sub>', $question['B']);
    $question['C'] = preg_replace('/!(.+)/', '<sub>$1</sub>', $question['C']);
    $question['D'] = preg_replace('/!(.+)/', '<sub>$1</sub>', $question['D']);

    return $question;
}, $questions);

// Return the modified questions as HTML
header('Content-Type: text/html');
echo "<html><body><ul>";
foreach ($modifiedQuestions as $question) {
    echo "<li>{$question['question']}</li>";
    echo "<ul>";
    echo "<li>A: {$question['A']}</li>";
    echo "<li>B: {$question['B']}</li>";
    echo "<li>C: {$question['C']}</li>";
    echo "<li>D: {$question['D']}</li>";
    echo "<li>ANS: {$question['ANS']}</li>";
    echo "<li>Justification: {$question['justification']}</li>";
    echo "<li>Category: {$question['category']}</li>";
    echo "</ul>";
}
echo "</ul></body></html>";
