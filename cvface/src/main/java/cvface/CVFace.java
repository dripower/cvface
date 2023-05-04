package cvface;

import java.awt.image.BufferedImage;
import java.awt.image.DataBufferByte;
import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.nio.ByteBuffer;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.attribute.PosixFilePermissions;
import java.util.Arrays;
import java.util.Base64;

import javax.imageio.ImageIO;

import org.opencv.core.Core;
import org.opencv.core.CvType;
import org.opencv.core.Mat;
import org.opencv.core.MatOfByte;
import org.opencv.imgcodecs.Imgcodecs;

public class CVFace {

  public static Mat base64DecodeImg(String img) {
    return Imgcodecs.imdecode(new MatOfByte(java.util.Base64.getDecoder().decode(img)), Imgcodecs.IMREAD_COLOR);
  }

  public static void loadLib() throws IOException {
    String libName = Core.NATIVE_LIBRARY_NAME;
    String fullLibName = System.mapLibraryName(libName);
    System.out.println("loading lib " + fullLibName);
    InputStream libInStream = CVFace.class.getClassLoader().getResourceAsStream("opencv/" + fullLibName);
    Path tmpLib = Paths.get(System.getProperty("java.io.tmpdir"), fullLibName);
    if (Files.exists(tmpLib)) {
      Files.delete(tmpLib);
    }
    Files.copy(libInStream, tmpLib);
    Files.setPosixFilePermissions(tmpLib, PosixFilePermissions.fromString("r-xr-xr-x"));

    System.load(tmpLib.toAbsolutePath().toString());
  }

  public static void main(String... args) {
    try {
      loadLib();
      // 4 pixel image
      String base64EncodedImg = "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAIAAAACCAIAAAD91JpzAAABg2lDQ1BJQ0MgcHJvZmlsZQAAKJF9kT1Iw0AcxV/TFotUHMwg4pChOtlFRRxrFYpQIdQKrTqYXPoFTVqSFBdHwbXg4Mdi1cHFWVcHV0EQ/ABxdXFSdJES/5cUWsR4cNyPd/ced+8AoVVluhVKALphm5lUUsrlV6W+V4QgIowYIgqz6nOynIbv+LpHgK93cZ7lf+7PMaAVLAYEJOIEq5s28QbxzKZd57xPLLKyohGfE0+YdEHiR66rHr9xLrks8EzRzGbmiUViqdTDag+zsqkTTxPHNN2gfCHnscZ5i7NebbDOPfkLowVjZZnrNEeRwiKWIEOCigYqqMJGnFaDFAsZ2k/6+Edcv0wulVwVMHIsoAYdiusH/4Pf3VrFqUkvKZoEwi+O8zEG9O0C7abjfB87TvsECD4DV0bXX2sBs5+kN7ta7AgY3AYurruaugdc7gDDT3XFVFwpSFMoFoH3M/qmPDB0C/Sveb119nH6AGSpq/QNcHAIjJcoe93n3ZHe3v490+nvB1G9cpn5tB68AAAACXBIWXMAAC4jAAAuIwF4pT92AAAAB3RJTUUH5wQUBSczjrD2CgAAABl0RVh0Q29tbWVudABDcmVhdGVkIHdpdGggR0lNUFeBDhcAAAAWSURBVAjXY2BkZPz//z/D////GRkZASoOBgG+F4KQAAAAAElFTkSuQmCC";
      String base64Prefix = "base64,";
      int prefixIndex = base64EncodedImg.indexOf(base64Prefix);
      int dataStartIndex = prefixIndex == -1 ? 0 : prefixIndex + base64Prefix.length();
      String imgData = base64EncodedImg.substring(dataStartIndex);
      Mat imgMat = base64DecodeImg(imgData);
      for (int x = 0; x < imgMat.width(); x ++) {
        for (int y = 0; y < imgMat.height(); y++) {
          System.out.println("pixel at (" + x + "," + y + ") " + Arrays.toString(imgMat.get(x, y)));
        }
      }
      double[] pixels = imgMat.get(0, 1);
      System.out.println(Arrays.toString(pixels));
    } catch (IOException e) {
      e.printStackTrace();
    }
  }

}
