class NoteController < ApplicationController
    
    def index
        @note = Note.new
        @tags = []
        @count = []
        if HashTagsNote.count != 0
            HashTagsNote.all.order(created_at: "desc").group_by(&:updated_at).values.each do |a|
                if a.length == 1
                    puts "Hello"
                    @tags.push(HashTag.find(a[0].hash_tag_id))
                else
                    temp = 0
                  a.each do |hash_tag|
                    count =  HashTagsNote.where(hash_tag_id: hash_tag.hash_tag_id).count
                    @count.push({id: hash_tag.hash_tag_id, count: count})
                  end
                end
            end
            @count.uniq! {|u| u[:id]}
            @sorted = @count.sort_by { |hsh| hsh[:count] }.reverse
            @sorted.each do |hash|
                @tags.push(HashTag.find(hash[:id]))
            end
        end
    end

    def create
        @note = Note.new(note_params)
        if @note.save
          @hash_tag = note_params[:note].split()
          @hash_tag.each do |h_tag|
            if h_tag.start_with? "#"
                @tag = HashTag.find_by(hash_tag: h_tag)
                if !@tag.present?
                    @note.hash_tags.create(:hash_tag => h_tag)
                else
                    @note.hash_tags_notes.create(:note_id=> @note.id, hash_tag_id: @tag.id)
                end
            end
          end
          redirect_to notes_path
        end
    end

    def hashtag
        @hashtag = HashTag.find(params[:id])
        if @hashtag.present?
            @notes = @hashtag.notes.order(updated_at: :desc)
            respond_to do |format|
                format.js { render "notes.js.erb" }
            end
        end
    end

    def update_note
        @note = Note.find(note_params[:id])
        if @note.present?
            @note.hash_tags_notes.delete_all
            @tags = []
            @count = []
            if @note.update(note_params)
                @hash_tag = note_params[:note].split()
                @hash_tag.each do |tag|
                    if tag.start_with? "#"
                        @tag = HashTag.find_by(hash_tag: tag)
                        if !@tag.present?
                            @note.hash_tags.create(:hash_tag => tag)
                        else
                            @note.hash_tags_notes.create(:note_id=> @note.id, hash_tag_id: @tag.id)
                        end
                    end
                end
                if HashTagsNote.count != 0
                    HashTagsNote.all.order(created_at: "desc").group_by(&:updated_at).values.each do |a|
                        if a.length == 1
                            puts "Hello"
                            @tags.push(HashTag.find(a[0].hash_tag_id))
                        else
                            temp = 0
                          a.each do |hash_tag|
                            count =  HashTagsNote.where(hash_tag_id: hash_tag.hash_tag_id).count
                            @count.push({id: hash_tag.hash_tag_id, count: count})
                          end
                        end
                    end
                    @count.uniq! {|u| u[:id]}
                    @sorted = @count.sort_by { |hsh| hsh[:count] }.reverse
                    @sorted.each do |hash|
                        @tags.push(HashTag.find(hash[:id]))
                    end
                end
                respond_to do |format|
                    format.js {render "index.js.erb" }
                end
            end
        end
    end

    def destroy
        @note = Note.find(params[:id])
        @tags = []
        @count = []
        if HashTagsNote.count != 0
            HashTagsNote.all.order(created_at: "desc").group_by(&:updated_at).values.each do |a|
                if a.length == 1
                    puts "Hello"
                    @tags.push(HashTag.find(a[0].hash_tag_id))
                else
                    temp = 0
                  a.each do |hash_tag|
                    count =  HashTagsNote.where(hash_tag_id: hash_tag.hash_tag_id).count
                    @count.push({id: hash_tag.hash_tag_id, count: count})
                  end
                end
            end
            @count.uniq! {|u| u[:id]}
            @sorted = @count.sort_by { |hsh| hsh[:count] }.reverse
            @sorted.each do |hash|
                @tags.push(HashTag.find(hash[:id]))
            end
        end
        if @note.present?
            @note.hash_tags.delete_all
            @note.delete
            respond_to do |format|
                format.js {render "update.js.erb" }
            end
        end
    end

    private
    def note_params
        params.require(:note).permit(:id, :note)
    end
end
