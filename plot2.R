getData <- function() {
    fieldNames <- names (
        read.table (
            file   = "household_power_consumption.txt",
            header = TRUE,
            sep    = ";",
            nrows  = 1
        )
    )
    data <- read.table (
        file       = "household_power_consumption.txt",
        sep        = ";",
        col.names  = fieldNames,
        na.strings = "?",
        skip       = 66637,
        nrows      = 2880
    )
    data$DateTime <- strptime (
        paste (
            data$Date,
            data$Time,
            sep = " "
        ),
        format = "%d/%m/%Y %H:%M:%S"
    )
    data
}

Sys.setlocale (
    category = "LC_TIME",
    locale   = "C"
)
data <- getData()
png (
    filename = "plot2.png",
    width    = 480,
    height   = 480,
    units    = "px"
)
with (
    data = data,
    expr = {
        plot (
            x    = DateTime,
            y    = Global_active_power,
            type = "n",
            xlab = "",
            ylab = "Global Active Power (kilowatts)"
        )
        lines (
            x = DateTime,
            y = Global_active_power
        )
    }
)
dev.off()
