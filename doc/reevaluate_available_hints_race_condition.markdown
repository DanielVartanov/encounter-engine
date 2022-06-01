On possible race conditions in `Play#reevaluate_available_hints`
================================================================

Yes, it is possible if between reading the play and associated
entities and reevaluation:
 1. Play advances to the next level
 2. More hints are added to the level
 3. Existing hints change their delay

Perhaps the most frequent (though, still very rare) is (3). We are
going to check if it really happens in real life. For that we need to
write to log each time `latest_available_hint_id` does not belong to
`current_level` and then set an alert for such log.
