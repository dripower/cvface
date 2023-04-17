package cvface;

import java.awt.image.BufferedImage;
import java.awt.image.DataBufferByte;
import java.io.IOException;
import java.io.InputStream;
import java.nio.ByteBuffer;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.attribute.PosixFilePermissions;

import org.opencv.core.Core;
import org.opencv.core.CvType;
import org.opencv.core.Mat;

public class CVFace {

	/**
	 * Wrap a buffered image into a Mat.
	 * Note the returned Mat must not be closed, since its content is managed by jvm
	 */
	public static Mat bufferedImageToMat(BufferedImage bi) {
		byte[] data = ((DataBufferByte) bi.getRaster().getDataBuffer()).getData();
		return new Mat(bi.getHeight(), bi.getWidth(), CvType.CV_8UC3, ByteBuffer.wrap(data));
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
		Files.setPosixFilePermissions(tmpLib, PosixFilePermissions.fromString("rwxr-xr-x"));

		System.load(tmpLib.toAbsolutePath().toString());
	}

}
