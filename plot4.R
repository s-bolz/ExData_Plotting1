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
    filename = "plot4.png",
    width    = 480,
    height   = 480,
    units    = "px"
)
par(mfrow = c(2, 2))
with (
    data = data,
    expr = {
        plot (
            x    = DateTime,
            y    = Global_active_power,
            type = "n",
            xlab = "",
            ylab = "Global Active Power"
        )
        lines (
            x = DateTime,
            y = Global_active_power
        )
        plot (
            x    = DateTime,
            y    = Voltage,
            type = "n",
            xlab = "datetime",
            ylab = "Voltage"
        )
        lines (
            x = DateTime,
            y = Voltage
        )
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
            lty    = "solid",
            bty    = "n"
        )
        plot (
            x    = DateTime,
            y    = Global_reactive_power,
            type = "n",
            xlab = "datetime",
            ylab = "Global_reactive_power"
        )
        lines (
            x = DateTime,
            y = Global_reactive_power
        )
    }
)
dev.off()
par(mfrow = c(1, 1))
