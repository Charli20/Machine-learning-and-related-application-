
    library(mice)

    args <- commandArgs(trailingOnly = TRUE)

    train <- read.csv(
        args[1],
        check.names = FALSE,
        na.strings = c("", "NA")
    )

    validation <- read.csv(
        args[2],
        check.names = FALSE,
        na.strings = c("", "NA")
    )

    combined <- rbind(train, validation)

    # Convert categorical predictors to factors
    combined[] <- lapply(combined, as.factor)

    # Explicit ordering for composite counts
    for (col in c("disability_count", "comorbidity_count")) {

        if (col %in% names(combined)) {

            combined[[col]] <- factor(
                combined[[col]],
                levels = c("0", "1-2", "3+"),
                ordered = TRUE
            )
        }
    }

    methods <- make.method(combined)

    ignored_rows <- c(
        rep(FALSE, nrow(train)),
        rep(TRUE, nrow(validation))
    )

    result <- mice(
        combined,
        m = 5,
        maxit = 10,
        method = methods,
        ignore = ignored_rows,
        seed = 42,
        printFlag = FALSE
    )

    write.csv(result$loggedEvents, file.path(dirname(args[3]), "logged_events.csv"), row.names = FALSE)
    if (!is.null(result$loggedEvents)) print(result$loggedEvents)

    # Simplified analysis: use completed dataset 1
    completed <- complete(result, 1)

    train_imputed <- completed[
        seq_len(nrow(train)),
        ,
        drop = FALSE
    ]

    validation_imputed <- completed[
        nrow(train) + seq_len(nrow(validation)),
        ,
        drop = FALSE
    ]

    write.csv(
        train_imputed,
        args[3],
        row.names = FALSE
    )

    write.csv(
        validation_imputed,
        args[4],
        row.names = FALSE
    )
    