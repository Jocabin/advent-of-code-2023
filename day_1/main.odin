package main

import "core:os"
import "core:fmt"
import "core:strings"
import "core:unicode"

main :: proc() {
    content, ok := os.read_entire_file("input.txt")

    if !ok {
        fmt.println("Error while reading file")
        return
    }

    defer delete(content)

    total: u32
    find_n, first_n, last_n : i32 = -1, -1, -1
    part_2 := false

    for char, i in content {
        if char >= 48 && char <= 57 {
            find_n = i32(char - '0')
        } else if char == '\n' {
            total += u32((first_n * 10) + last_n)
            first_n, last_n = -1, -1
        } else {
            if part_2 {
                switch char {
                case 'o': if check_word(content, i, "one") do find_n = 1
                case 't': {
                    if check_word(content, i, "two") do find_n = 2
                    if check_word(content, i, "three") do find_n = 3
                }
                case 'f': {
                    if check_word(content, i, "four") do find_n = 4
                    if check_word(content, i, "five") do find_n = 5
                }
                case 's': {
                    if check_word(content, i, "six") do find_n = 6
                    if check_word(content, i, "seven") do find_n = 7
                }
                case 'e': if check_word(content, i, "eight") do find_n = 8
                case 'n': if check_word(content, i, "nine") do find_n = 9
                }
            }
        }

        if find_n != -1 {
            if first_n == -1 do first_n = find_n

            last_n = find_n
            find_n = -1
        }
    }

    fmt.println("total: ", total)
}

check_word :: proc (content: []u8, char_pos: int, word: string) -> bool {
    max_offset := char_pos + len(word)

    if (max_offset <= len(content)) {
        slice := string(content[char_pos:max_offset])

        if slice == string(word) {
            return true
        }
    }
    return false
}