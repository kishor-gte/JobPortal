package in.sp.main.rest.common.utils;

import in.sp.main.rest.common.response.PageResponse;
import org.springframework.data.domain.Page;

public class PaginationUtils {

    public static <T> PageResponse<T> toPageResponse(Page<T> page) {
        return new PageResponse<>(
                page.getContent(),
                page.getNumber(),
                page.getTotalPages(),
                page.getTotalElements(),
                page.isLast()
        );
    }
}
