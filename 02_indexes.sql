CREATE UNIQUE INDEX "User_email_key" ON "User"("email");
CREATE UNIQUE INDEX "Language_name_key" ON "Language"("name");
CREATE UNIQUE INDEX "Language_slug_key" ON "Language"("slug");
CREATE INDEX "TypingSession_userId_date_idx" ON "TypingSession"("userId", "date");
CREATE INDEX "TypingSession_snippetId_idx" ON "TypingSession"("snippetId");
CREATE INDEX "TypingSession_userId_status_idx" ON "TypingSession"("userId", "status");