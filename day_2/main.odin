package main

import "core:fmt"
import "core:os"

main :: proc() {
	content := #load("input.txt")

	max_red, max_green, max_blue := 12, 13, 14
	fewest_red, fewest_green, fewest_blue := 0, 0, 0
	red, green, blue: int
	start_passed, line_valid := false, true
	total_power, total: int
	line_i := 1
	double_number := false
	part_2 := true

	for char, i in content {
		if !line_valid {
			if char != '\n' do continue
		}

		if start_passed == false {
			if char != ':' {
				continue
			} else if char == ':' {
				start_passed = true
			}
		} else if char == '\n' || char == ';' {
			red, green, blue = 0, 0, 0

			if char == '\n' {
				total_power += fewest_red * fewest_green * fewest_blue
				if line_valid {
					total += line_i
				}

				fewest_red, fewest_green, fewest_blue = 0, 0, 0
				line_valid = true
				start_passed = false
				line_i += 1
			}
		} else if is_digit(char) {
			next_char := content[i + 1]
			final_digit, offset: int

			if double_number {
				double_number = false
				continue
			}

			if is_digit(next_char) {
				offset = 3
				final_digit = (int(char - '0') * 10) + int(next_char - '0')
				double_number = true
			} else {
				offset = 2
				final_digit = int(char - '0')
			}

			switch content[i + offset] {
			case 'r':
				red += final_digit
			case 'g':
				green += final_digit
			case 'b':
				blue += final_digit
			}

			if red > fewest_red do fewest_red = red
			if green > fewest_green do fewest_green = green
			if blue > fewest_blue do fewest_blue = blue

			if !part_2 {
				if red > max_red || green > max_green || blue > max_blue {
					line_valid = false
				}
			}
		}
	}

	fmt.println("total", total)
	fmt.println("total power", total_power)
}

is_digit :: proc(n: u8) -> bool {
	return n >= 48 && n <= 57
}
