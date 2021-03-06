require "sdoc_site/version"
require "sdoc"
require "rake"

class SDocSite::Automation::Ruby
  def initialize automation
    @automation = automation
  end
  
  def name
    'Ruby'
  end
  
  def description
    ''
  end
  
  def short_name
    'ruby'
  end
  
  def versions_to_build
    1
  end
  
  def available_versions
    [SDocSite::Version.new('2.0.0')]
  end
  
  def build_doc version
    @tmp_path = @automation.temp_dir
    doc_dir = @automation.temp_dir
    if true
      `svn checkout http://svn.ruby-lang.org/repos/ruby/tags/v1_9_3_0 #{@tmp_path}`
      in_tmp do
        run_sdoc_1_9 doc_dir
      end
		elsif true
      `svn checkout http://svn.ruby-lang.org/repos/ruby/tags/v2_0_0_0 #{@tmp_path}`
      in_tmp do
        run_sdoc_1_9 doc_dir
      end
    end
    doc_dir
  end
  
protected
  def run_sdoc_1_8 target
    options = []
    options << "-o" << target
    options << "-a"
    options << '--line-numbers' 
    options << '--main' << 'README'
    options << '--title' << 'Ruby'
    options << '-f' << 'sdoc'
    options << '-T' << 'direct'
    file_list = Rake::FileList.new
    file_list.include('README')
    file_list.include('COPYING')
    file_list.include('NEWS')
    file_list.include('LEGAL')
    file_list.include('LGPL')
    file_list.include('GPL')
    file_list.include('*.{c,h,rb}')
    file_list.include('lib/**/*.{c,h,rb}')
    file_list.include('ext/**/*.{c,h,rb}')
    file_list.exclude('ext/win32ole')
    file_list.exclude('ext/tk')
    file_list.exclude('lib/drb')
    file_list.exclude('lib/irb')
    file_list.exclude('lib/rake')
    file_list.exclude('lib/rdoc')
    file_list.exclude('lib/rss')
    file_list.exclude('lib/rinda')
    file_list.exclude('lib/webric')
    options += file_list.to_a
    RDoc::RDoc.new.document(options)
  end
  
  def run_sdoc_1_9 target
    options = []
    options << "-o" << target
    options << "-a"
    options << '--line-numbers' 
    options << '-f' << 'sdoc'
    options << '-T' << 'direct'
    options << '--title' << 'Ruby'
    options << '--main' << 'README'
    file_list = Rake::FileList.new
    file_list.include('README')
    file_list.include('COPYING')
    file_list.include('NEWS')
    file_list.include('LEGAL')
    file_list.include('LGPL')
    file_list.include('GPL')
    file_list.include('*.{c,h,rb}')
    file_list.include('lib/**/*.{c,h,rb}')
    file_list.include('ext/**/*.{c,h,rb}')
    file_list.exclude('ext/win32ole')
    file_list.exclude('ext/tk')
    file_list.exclude('lib/drb')
    file_list.exclude('lib/irb')
    file_list.exclude('lib/rake')
    file_list.exclude('lib/rdoc')
    file_list.exclude('lib/rss')
    file_list.exclude('lib/rinda')
    file_list.exclude('lib/webric')
    options += file_list.to_a
    RDoc::RDoc.new.document(options)
  end

  def in_tmp &block
    cwd = Dir.pwd
    begin
      Dir.chdir @tmp_path
      yield
    ensure
      Dir.chdir cwd
    end
  end
end
