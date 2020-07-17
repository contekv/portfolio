module ApplicationHelper

    #各ページにタイトルを渡す
    def full_title(page_title ="")
        base_title = "MediRoom"
        if page_title.empty?
           base_title
        else
            page_title + "|" + base_title
        end
    end
end
