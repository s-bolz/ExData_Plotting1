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
    filename = "plot3.png",
    width    = 480,
    height   = 480,
    units    = "px"
)
with (
    data = data,
    expr = {
        plot (
            x    = DateTime,
            y    = Sub_metering_1,
            type = "n",
            xlab = "",
            ylab = "Energy sub metering"
        )
        lines (
            x   = DateTime,
            y   = Sub_metering_1,
            col = "black"
        )
        lines (
            x   = DateTime,
            y   = Sub_metering_2,
            col = "red"
        )
        lines (
            x   = DateTime,
            y   = Sub_metering_3,
            col = "blue"
        )
        legend (
            x      = "topright",
            legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
            col    = c("black", "red", "blue"),
            lty    = "solid"
        )
    }
)
dev.off()
