# Usually I would extract the getData() function into its own file to be
# sourced by all plot scripts, but I deliberately decided against it since the
# instructions explicitly state that "There should be four PNG files and four
# R code files" in my GitHub repository and I want to be formally on the safe
# side here. Thus I had to copy the source code of the getData() function
# into every plot script.
# This function assumes the source data is already located in the current
# working directory which should be formally safe as well, since the
# instructions only state that my code file "should include code for reading
# the data" and not for downloading the data.
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
