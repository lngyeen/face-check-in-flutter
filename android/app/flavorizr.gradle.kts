import com.android.build.gradle.AppExtension

val android = project.extensions.getByType(AppExtension::class.java)

android.apply {
    flavorDimensions("flavor-type")

    productFlavors {
        create("dev") {
            dimension = "flavor-type"
            applicationId = "com.owt.face_check_in_flutter.dev"
            resValue(type = "string", name = "app_name", value = "Face Check-In Dev")
        }
        create("stag") {
            dimension = "flavor-type"
            applicationId = "com.owt.face_check_in_flutter.stag"
            resValue(type = "string", name = "app_name", value = "Face Check-In Staging")
        }
        create("prod") {
            dimension = "flavor-type"
            applicationId = "com.owt.face_check_in_flutter"
            resValue(type = "string", name = "app_name", value = "Face Check-In")
        }
    }
}