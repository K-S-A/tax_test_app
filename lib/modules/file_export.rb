###############################################################################
# Module holds file export functionality.
###############################################################################
module FileExport
  def export_to(file_name)
    File.write("export/#{file_name}", to_s)
  end
end
