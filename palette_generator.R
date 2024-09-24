
# palette generator

color_x <- "#4170fe"
color_y <- "#ff6702"
corner <- "#ac005f"
white <- "white"

col_white_col <- colorRampPalette(c(color_x, white, color_y), space = "rgb",
                                      interpolate = "linear", alpha = FALSE)
col_white_col(7)

col_corner_col <- colorRampPalette(c(color_x, corner, color_y), space = "rgb",
                                   interpolate = "linear", alpha = FALSE)
col_corner_col(7)


col_col <- colorRampPalette(c(color_x, color_y), space = "rgb",
                            interpolate = "linear", alpha = FALSE)

col_col(4)[2:3] # -1 diagonal

diag_x_lower <- col_white_col(7)[6]
diag_y_lower <- col_white_col(5)[2]


diag_lower <- colorRampPalette(c(diag_x_lower, diag_y_lower), space = "rgb",
                               interpolate = "linear", alpha = FALSE)
diag_lower(3)[2]

diag_x_upper <- col_corner_col(7)[5]
diag_y_upper <- col_corner_col(7)[3]

diag_upper <- colorRampPalette(c(diag_x_upper, diag_y_upper), space = "rgb",
                               interpolate = "linear", alpha = FALSE)
diag_upper(3)[2] # +1 diagonal


r4 <- c(color_x, col_corner_col(7)[2], col_corner_col(7)[3], col_corner_col(7)[4])
r3 <- c(col_white_col(7)[2], col_col(4)[2], diag_upper(3)[2], col_corner_col(7)[5])
r2 <- c(col_white_col(7)[3], diag_lower(3)[2], col_col(4)[3], col_corner_col(7)[6])
r1 <- c(white, col_white_col(7)[5], col_white_col(7)[6], color_y)


st_sfc(st_polygon(list(rbind(c(0,0), c(1,0), c(1,1), c(0,0))))) |>
  st_make_grid(n = c(4, 4)) |>
  st_sf() |>
  mutate(id = 1:16) |>
  cbind(n_values) |>
  rename(n = Freq)

# get color codes for palette
bi_cols <- sapply(cbind(r1, r2, r3, r4), unlist)

# create legend
tm_shape(bi_grid) +
  tm_polygons(col = "id", pal = bi_cols, 
              style = "cont", legend.show = FALSE,
              lwd = 0) +
  tm_text("n", size = 1.5) +
  tm_layout(frame = FALSE)





