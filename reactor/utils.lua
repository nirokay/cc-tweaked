local config = require("config")

local utils = {}

function utils.getPercentage(dividend, divisor, topNumber)
    local maxNumber = topNumber or 15
    local result = dividend / divisor * 10

    if result > maxNumber then result = maxNumber end
    return config.mathRoundingFunction(result)
end

return utils
