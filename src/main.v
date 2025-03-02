module main

import os
import check
import live

// format_link ensures the input link has https and www prefix
pub fn format_link(link string) string {
	mut result := link

	// handle www only prefix
	if result.starts_with('www.') {
		result = 'https://' + result
	}
	// handle full urls with www
	else if result.starts_with('https://www.') || result.starts_with('http://www.') {
		if result.starts_with('http://www.') {
			result = 'https://www.' + result[11..]
		}
	}
	// handle urls without www
	else if result.starts_with('https://') || result.starts_with('http://') {
		if result.starts_with('http://') {
			result = 'https://' + result[7..]
		}
		if !result.contains('www.') {
			result = result.replace('https://', 'https://www.')
		}
	}
	// handle bare domains
	else {
		result = 'https://www.' + result
	}
	return result
}

// validate_args checks if the command line arguments are valid
fn validate_args(args []string) bool {
	if args.len < 1 || args.len > 4 {
		return false
	}
	return true
}

fn main() {
	// get and process command line arguments
	mut args := unsafe { os.args[1..] } // skip program name

	if !validate_args(args) {
		println('usage: \x1b[34mpulse\x1b[0m <link> [options]\n')
		println('options:\n')
		println('  -v, --version\t\tShow program\'s version number and exit')
		println('  -l, --live\t\tMonitor website for changes in availability')
		println('  --t <seconds>\t\tSet refresh interval for live monitoring (default: 15)')
		return
    }
    
	// check for version flag
	if args[0] == "-v" || args[0] == "--version" {
		println("pulse v0.1.0")
		return
	}

	// format the provided link
	mut link := format_link(args[0])
	
	// check for live monitoring flag
	mut is_live := false
	mut refresh_interval := 15 // default refresh interval in seconds
    
	for i := 1; i < args.len; i++ {
		match args[i] {
			'-l', '--live' { is_live = true }
			'--t' {
				if i + 1 < args.len {
					refresh_interval = args[i + 1].int()
					if refresh_interval < 1 {
						refresh_interval = 15 // reset to default if invalid
					}
					i++ // skip the next argument since it's the interval value
				}
			}
			else {}
		}
	}
	
	// perform the website check
	if is_live {
		live.monitor_website(link, refresh_interval)
	} else {
		check.check_website(link)
	}
}
