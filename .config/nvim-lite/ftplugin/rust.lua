vim.api.nvim_create_user_command("CargoClippy", function()
	-- Run cargo clippy with JSON output and capture the output
	local output = vim.fn.system("cargo clippy --all-features --all-targets --message-format=json -- -D warnings")
	local lines = vim.fn.split(output, "\n")

	-- Prepare the quickfix list
	local quickfix_list = {}

	-- Process each JSON line
	for _, line in ipairs(lines) do
		if line ~= "" then
			-- Safely decode JSON, skipping lines that cannot be parsed
			local success, data = pcall(vim.fn.json_decode, line)
			if success and data and data.message and data.message.spans and #data.message.spans > 0 then
				for _, span in ipairs(data.message.spans) do
					if span.is_primary then
						table.insert(quickfix_list, {
							filename = span.file_name,
							lnum = span.line_start,
							col = span.column_start,
							text = data.message.message,
							type = data.message.level:sub(1, 1):upper(), -- Convert 'warning' or 'error' to 'W' or 'E'
						})
					end
				end
			end
		end
	end

	-- Set the quickfix list
	vim.fn.setqflist(quickfix_list)
	vim.api.nvim_command("copen")
end, {})
