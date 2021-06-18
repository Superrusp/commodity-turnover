package com.kpi.springlabs.backend.model;

import com.kpi.springlabs.backend.utils.Constants;
import lombok.Getter;
import lombok.Setter;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.DBRef;
import org.springframework.data.mongodb.core.mapping.Document;

import java.time.Instant;

@Document(collection = Constants.DocumentNames.REFRESH_TOKENS)
@Setter
@Getter
public class RefreshToken {

    @Id
    private String id;

    private String tokenValue;

    private Instant createdDate;

    @DBRef
    private User user;

    public RefreshToken(String tokenValue, User user) {
        this.tokenValue = tokenValue;
        this.createdDate = Instant.now();
        this.user = user;
    }
}