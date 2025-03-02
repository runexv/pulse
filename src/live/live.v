module live

import os
import time
import check

// monitor_website continuously checks a website's availability at specified intervals
pub fn monitor_website(link string, refresh_interval int) {
	// ensure curl is available
	if !check.ensure_curl_installed() {
		println('error: curl is required but not available')
		return
	}

	// initial check
	result := os.execute('curl -s -o /dev/null -w "%{http_code}" ${link}')
	mut previous_status := result.output
	mut was_accessible := previous_status in check.status_meanings.keys()

	// display initial status
	if was_accessible {
		if previous_status == '200' {
			println('\x1b[32m👍 the website is up and working (status: 200 "${check.status_meanings['200']}")\x1b[0m')
		} else {
			println('\x1b[32m👍 the website is working (status: ${previous_status} "${check.status_meanings[previous_status]}")\x1b[0m')
		}
	} else {
		println('\x1b[31m❌ the website is not accessible (status: ${previous_status})\x1b[0m')
	}

	// monitoring loop
	for {
		// wait for the specified interval
		time.sleep(refresh_interval * time.second)

		// check website status
		current_result := os.execute('curl -s -o /dev/null -w "%{http_code}" ${link}')
		current_status := current_result.output
		is_accessible := current_status in check.status_meanings.keys()
		current_time := time.now()

		// only report if status changed
		if is_accessible != was_accessible {
			if is_accessible {
				println('\x1b[34m❕ the website is now accessible (status: ${current_status}, time: ${current_time})\x1b[0m')
			} else {
				println('\x1b[34m❕ the website is no longer accessible (status: ${current_status}, time: ${current_time})\x1b[0m')
			}

			// update previous state
			was_accessible = is_accessible
			previous_status = current_status
		}
	}
}
