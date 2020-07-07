module ApplicationHelper

    #各ページにタイトルを渡す
    def full_title(page_title ="")
        base_title = "Medical App"
        if page_title.empty?
            base_title
        else
            page_title + "|" + base_title
        end
    end
end
