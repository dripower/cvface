plugins {
    `java-library`
}

java {
    sourceCompatibility = JavaVersion.VERSION_11
    targetCompatibility = JavaVersion.VERSION_11
}

sourceSets {
    main {
        java.srcDir("src/main/java")
        java.srcDir("src/gen/java")
        resources.srcDir("src/gen/lib")
    }
}
