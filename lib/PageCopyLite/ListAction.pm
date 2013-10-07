package PageCopyLite::ListAction;

use strict;
use warnings;

use MT::Entry;
use MT::Page;

# ウェブページコピー
sub hdlr_func1{
    # パラメータ取得
    my ($app) = @_;
    
    # パラメータコンテキスト取得
    my $q = $app->param;
    
    # ブログID取得
    my $blog_id = $q->param('blog_id');
	
	# id取得
	my @ids = $q->param('id');
	
	# 取得したid分処理
    for my $pageId (@ids) {
    	
    	# ページ
    	my $page = MT::Page->load({ 
							blog_id => $blog_id,	# インポートするＣＭＳのブログID
							id => $pageId			# id
					    });
		
		# ページオブジェクト生成
		my $newPage = MT::Page->new();
		
		# パラメータコピー
		$newPage->blog_id($page->blog_id());
		$newPage->status($page->status());
		$newPage->allow_comments($page->allow_comments());
		$newPage->title("copy_" . $page->title());
		$newPage->convert_breaks($page->convert_breaks());
		$newPage->to_ping_urls($page->to_ping_urls());
		$newPage->pinged_urls($page->pinged_urls());
		$newPage->allow_pings($page->allow_pings());
		$newPage->keywords($page->keywords());
		$newPage->tangent_cache($page->tangent_cache());
		$newPage->basename("copy_" . $page->basename());
		$newPage->atom_id($page->atom_id());
		$newPage->template_id($page->template_id());
		$newPage->comment_count($page->comment_count());
		$newPage->ping_count($page->ping_count());
		
		$newPage->text($page->text());
		$newPage->text_more($page->text_more());
		
        my @ts = MT::Util::offset_time_list( time, $blog_id );
		my $ts = sprintf '%04d%02d%02d%02d%02d%02d',
		    $ts[5] + 1900, $ts[4] + 1, @ts[ 3, 2, 1, 0 ];
		$newPage->authored_on($ts);
		
		$newPage->created_on($ts);
		$newPage->modified_on($ts);
		$newPage->author_id($page->author_id());
		$newPage->created_by($page->created_by());
		$newPage->modified_by($page->modified_by());
		
	    # 保存
	    $newPage->save()
	        or die "Saving MT::Page failed: ", $newPage->errstr;
		
    }
    
	
    # 画面を再表示
    return $app->redirect(
        $app->uri(
            mode => 'list',
            args => {
                _type => 'page',
                blog_id => $blog_id,
            },
        )
    );
}

# 記事コピー
sub hdlr_func2{
    # パラメータ取得
    my ($app) = @_;
    
    # パラメータコンテキスト取得
    my $q = $app->param;
    
    # ブログID取得
    my $blog_id = $q->param('blog_id');
	
	# id取得
	my @ids = $q->param('id');
	
	# 取得したid分処理
    for my $entryId (@ids) {
    	
    	# ページ
    	my $entry = MT::Entry->load({ 
							blog_id => $blog_id,	# インポートするＣＭＳのブログID
							id => $entryId			# id
					    });
		
		# ページオブジェクト生成
		my $newEntry = MT::Entry->new();
		
		# パラメータコピー
		$newEntry->blog_id($entry->blog_id());
		$newEntry->status($entry->status());
		$newEntry->allow_comments($entry->allow_comments());
		$newEntry->title("copy_" . $entry->title());
		$newEntry->convert_breaks($entry->convert_breaks());
		$newEntry->to_ping_urls($entry->to_ping_urls());
		$newEntry->pinged_urls($entry->pinged_urls());
		$newEntry->allow_pings($entry->allow_pings());
		$newEntry->keywords($entry->keywords());
		$newEntry->tangent_cache($entry->tangent_cache());
		$newEntry->basename("copy_" . $entry->basename());
		$newEntry->atom_id($entry->atom_id());
		$newEntry->template_id($entry->template_id());
		$newEntry->comment_count($entry->comment_count());
		$newEntry->ping_count($entry->ping_count());
		
		$newEntry->text($entry->text());
		$newEntry->text_more($entry->text_more());
		
        my @ts = MT::Util::offset_time_list( time, $blog_id );
		my $ts = sprintf '%04d%02d%02d%02d%02d%02d',
		    $ts[5] + 1900, $ts[4] + 1, @ts[ 3, 2, 1, 0 ];
		$newEntry->authored_on($ts);
		
		$newEntry->created_on($ts);
		$newEntry->modified_on($ts);
		$newEntry->author_id($entry->author_id());
		$newEntry->created_by($entry->created_by());
		$newEntry->modified_by($entry->modified_by());
		
	    # 保存
	    $newEntry->save()
	        or die "Saving MT::Entry failed: ", $newEntry->errstr;
    	
    }
    
	
    # 画面を再表示
    return $app->redirect(
        $app->uri(
            mode => 'list',
            args => {
                _type => 'entry',
                blog_id => $blog_id,
            },
        )
    );
}

1;
