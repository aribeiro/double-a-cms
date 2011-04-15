$(function(){
  var open_image = 0;
  editor_add_on = $("<div class='editor_add_on'></div>");
  editor_add_on.hide();
  $(".tinymce").after(editor_add_on);

  $('textarea.tinymce').tinymce({
    // Location of TinyMCE script
    script_url : '/javascripts/libs/tiny_mce/tiny_mce.js',
   
    // Theme options
    theme : "advanced",
    plugins : "media,spellchecker,iespell",
    valid_elements : "@[id|class|style|title|dir<ltr?rtl|lang|xml::lang|onclick|ondblclick|"
                    + "onmousedown|onmouseup|onmouseover|onmousemove|onmouseout|onkeypress|"
                    + "onkeydown|onkeyup],a[rel|rev|charset|hreflang|tabindex|accesskey|type|"
                    + "name|href|target|title|class|onfocus|onblur],strong/b,em/i,strike,u,"
                    + "#p,-ol[type|compact],-ul[type|compact],-li,br,img[longdesc|usemap|"
                    + "src|border|alt=|title|hspace|vspace|width|height|align],-sub,-sup,"
                    + "-blockquote,-table[border=0|cellspacing|cellpadding|width|frame|rules|"
                    + "height|align|summary|bgcolor|background|bordercolor],-tr[rowspan|width|"
                    + "height|align|valign|bgcolor|background|bordercolor],tbody,thead,tfoot,"
                    + "#td[colspan|rowspan|width|height|align|valign|bgcolor|background|bordercolor"
                    + "|scope],#th[colspan|rowspan|width|height|align|valign|scope],caption,-div,"
                    + "-span,-code,-pre,address,-h1,-h2,-h3,-h4,-h5,-h6,hr[size|noshade],-font[face"
                    + "|size|color],dd,dl,dt,cite,abbr,acronym,del[datetime|cite],ins[datetime|cite],"
                    + "object[classid|width|height|codebase|*],param[name|value|_value],embed[type|width"
                    + "|height|src|*],script[src|type],map[name],area[shape|coords|href|alt|target],bdo,"
                    + "button,col[align|char|charoff|span|valign|width],colgroup[align|char|charoff|span|"
                    + "valign|width],dfn,fieldset,form[action|accept|accept-charset|enctype|method],"
                    + "input[accept|alt|checked|disabled|maxlength|name|readonly|size|src|type|value],"
                    + "kbd,label[for],legend,noscript,optgroup[label|disabled],option[disabled|label|selected|value],"
                    + "q[cite],samp,select[disabled|multiple|name|size],small,"
                    + "textarea[cols|rows|disabled|name|readonly],tt,var,big,"
                    + "iframe[src|title|width|height|allowfullscreen|frameborder]",
   
    // Theme options
    theme_advanced_buttons1 : "formatselect,bold,italic,removeformat,|,bullist,numlist,justifyleft,justifycenter,justifyright,|,link,imagegallery,videoembed,spellchecker,|,code",
    theme_advanced_buttons2 : "",
    theme_advanced_buttons3 : "",
    theme_advanced_toolbar_location : "top",
    theme_advanced_toolbar_align : "left",
    theme_advanced_statusbar_location : "bottom",
    theme_advanced_resizing : true,
    spellchecker_languages : "+English=en",
    setup : function(ed) {
      // Add a Image Gallery
      ed.addButton('imagegallery', {
        title : 'Add an Image',
        image : '/images/ico/insertimage.gif',
        onclick : function() {
          $.get('/admin/blog_images', function(data) {
            $(".editor_add_on").html(data);
            $(".editor_add_on").show();
            $('#new_blog_image').ajaxForm({
              target: '#output',
              dataType: 'script',
              beforeSubmit:  showRequest,
              success:       showResponse
            });
            
            // hidden form to IE
            if (/MSIE (\d+\.\d+);/.test(navigator.userAgent)){
             $('#new_blog_image').hide(); 
              $("#ieform").live("click", function(){
                $(".editor_add_on").html("").hide();
              });
              if((open_image % 2) == 0){
                $("#available_images").hide();
                $(".pictures").hide();
              }
              open_image++;
            }

            // add styling to pictures
            var picture_css = {"float":"left","margin":"5px", "width": "50px", "height":"50px"};
            $(".picture").css(picture_css);
            $("#upload_image_box .picture").css("");

            $(".controls").hide();
            $(".pictures").before("<br style='clear:both'/>");

            // method to include image to Editor
            $(".editor_append_image").live("click", function(){
              var image_src = $($(this).attr("data-src")).val();
              var image_alt = $(this).attr("data-alt");
              var image_align_position = $($(this).attr("data-align")).val();
              var image_align = image_align_position == "" ? "" : "align='"+image_align_position+"'";
              var image_tag = "<img src='"+ image_src +"' alt='"+image_alt+"' " + image_align + "/>";
              $(".mceEditor").tinymce().execCommand('mceInsertContent',false, image_tag);
              $(".editor_add_on").html("").hide();
              return false;
            });

            // Picture box to allow to elect pictire size before add to editor
            $(".picture a").live("click", function(){
              $("#new_blog_image").hide();
              $("#upload_image_box .picture .controls").hide();
              $(".pictures").append($("#upload_image_box .picture"));
              $(this).parent().css("");
              $(".pictures .picture").css(picture_css);
              $("#upload_image_box").html($(this).parent());
              $(this).parent().find(".controls").show();
              $("#upload_image_box .picture").css({"width":"500px", "float":"none"});
              return false;
            });
            // Close button
            $(".editor_add_on").prepend("<a href='#' id='close_image'>[x] close</a>");
            $("#close_image").live("click", function(){
              $(".editor_add_on").html("").hide();
              return false;
            });
            return false;
          });
        }
      });
      
      // Add a Image Gallery
      ed.addButton('videoembed', {
        title : 'Embed Video (and other flash)',
        image : '/images/ico/insertvideo.png',
        onclick : function() {
     
          // Close button
          $(".editor_add_on").append("<a href='#' id='close_image'>[x] close</a>");
            $("#close_image").live("click", function(){
            $(".editor_add_on").html("").hide();
            return false;
          });
	
          // Creating the video add box
          pop = $(".editor_add_on");
          pop.css({"width":"480px"});
          pop.append("<h1>Embed Video (and other flash)</h1>");
          pop.append("<textarea id='embed_video'></textarea><br/>");
          pop.append("<button id='append_video'>Insert</button>");
          pop.show();
          
          // Add video to editor body method
          $("#append_video").live("click", function(){
            $(".mceEditor").tinymce().execCommand('mceInsertContent',false, "<p>"+ $("#embed_video").val() + "</p>");
            $(".editor_add_on").html("").hide();
            return false;
          });
        }
      });
    }
  });
});

function showRequest(){
  spinner = $("<div id='upload_spinner'><p><img src='/images/indicator.gif' />Uploading...</p></div>");
  $("#new_blog_image").after(spinner);
  $("#new_blog_image").hide();
}

function showResponse(){
  var picture_css = {"float":"left","margin":"5px", "width": "50px", "height":"50px"};
  $(".picture").css(picture_css);
  $("#upload_image_box .picture").css("");
  $(".controls").hide();
  
  $("#upload_spinner").remove(); 
  $("#new_blog_image").show();
}
