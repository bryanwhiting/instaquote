test_that("insta_text() works for two lines", {
  ans <- insta_text(
    "Did you know?",
    "i am batman"
  )
  soln <- "<span style='font-size:30pt; font-family:Helvetica;'>
Did you know?
</span><br><span style='font-size:3pt; font-family:Helvetica;'>
**———————————————————————————————————————————————**
</span><br><br><span style='font-size:12pt; font-family:Helvetica;'>
i am batman
</span>"
  expect_equal(as.character(ans), soln)
})

test_that("insta_text() works for one lines", {
  ans <- insta_text("Did you know?")
  soln <- "<span style='font-size:30pt; font-family:Helvetica;'>
Did you know?
</span>"
  expect_equal(as.character(ans), soln)
})
