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

data <- getData()
png (
    filename = "plot1.png",
    width    = 480,
    height   = 480,
    units    = "px"
)
hist (
    x    = data$Global_active_power,
    col  = "red",
    main = "Global Active Power",
    xlab = "Global Active Power (kilowatts)"
)
dev.off()
